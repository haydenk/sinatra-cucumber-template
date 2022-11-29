require_relative 'boot'

require 'active_record'
require 'warden'
require 'haml'

Bundler.require(*ENV.fetch('RACK_ENV').to_sym)
require 'sinatra/reloader' if ENV.fetch('RACK_ENV').to_sym == :development
require 'sinatra/flash'

ActiveRecord::Encryption.configure(
  primary_key:         ENV.fetch('AR_PRIMARY_KEY'),
  deterministic_key:   ENV.fetch('AR_DETERMINISTIC_KEY'),
  key_derivation_salt: ENV.fetch('AR_KEY_DERIVATION_SALT')
)

# Load the helpers
Dir['./app/helpers/**/*.rb'].each { |f| require f }

# Load the models
Dir['./app/models/**/*.rb'].each { |f| require f }

Warden::Strategies.add(:password) do
  def valid?
    params['username'] && params['password']
  end

  def authenticate!
    user = User.find_by(username: params['username'])

    if user.nil?
      throw(:warden, message: "The username you entered does not exist.")
    elsif user.authenticate(params['password'])
      success!(user)
    else
      throw(:warden, message: "The username and password combination ")
    end
  end
end

module Template
  class BaseApp < Sinatra::Base
    helpers ApplicationHelpers
    configure :development, :test do
      register Sinatra::Reloader
    end

    configure do
      register Sinatra::Flash
      set :database_file, File.join(settings.root, 'config/database.yml')
      set :environment => ENV.fetch('RACK_ENV').to_sym ||= :development
      set :root, File.realpath('.')
      set :public_folder => File.join(settings.root, 'public')
      set :haml, :layout => 'layouts/application'.to_sym, :escape_html => false
      set :views => File.join(settings.root, 'app/views')
      enable :sessions
      set :session_secret, ENV.fetch('SESSION_SECRET')
    end

    use Warden::Manager do |config|
      # Tell Warden how to save our User info into a session.
      # Sessions can only take strings, not Ruby code, we'll store
      # the User's `id`
      config.serialize_into_session{|user| user.id }
      # Now tell Warden how to take what we've stored in the session
      # and get a User from that information.
      config.serialize_from_session{|id| User.find_by(id: id) }

      config.scope_defaults :default,
                            # "strategies" is an array of named methods with which to
                            # attempt authentication. We have to define this later.
                            strategies: [:password],
                            # The action is a route to send the user to when
                            # warden.authenticate! returns a false answer. We'll show
                            # this route below.
                            action: 'unauthenticated'
      # When a user tries to log in and cannot, this specifies the
      # app to send the user to.
      config.failure_app = self
    end

    Warden::Manager.before_failure do |env, opts|
      # Because authentication failure can happen on any request but
      # we handle it only under "post '/auth/unauthenticated'", we need
      # to change request to POST
      env['REQUEST_METHOD'] = 'POST'
      # And we need to do the following to work with  Rack::MethodOverride
      env.each do |key, value|
        env[key]['_method'] = 'post' if key == 'rack.request.form_hash'
      end
    end

    post '/unauthenticated' do
      session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?

      # Set the error and use a fallback if the message is not defined
      flash[:error] = env['warden.options'][:message] || "You must log in"
      redirect '/login'
    end
  end
end

# Load the controllers
Dir['./app/controllers/**/*.rb'].each { |f| require f }
