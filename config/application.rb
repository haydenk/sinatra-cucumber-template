require_relative 'boot'

require 'active_record'
require 'haml'

Bundler.require(*ENV.fetch('RACK_ENV').to_sym)
require 'sinatra/reloader' if ENV.fetch('RACK_ENV').to_sym == :development

ActiveRecord::Encryption.configure(
  primary_key:         ENV.fetch('AR_PRIMARY_KEY'),
  deterministic_key:   ENV.fetch('AR_DETERMINISTIC_KEY'),
  key_derivation_salt: ENV.fetch('AR_KEY_DERIVATION_SALT')
)

# Load the helpers
Dir['./app/helpers/**/*.rb'].each { |f| require f }

# Load the models
Dir['./app/models/**/*.rb'].each { |f| require f }

module Template
  class BaseApp < Sinatra::Base
    helpers ApplicationHelpers, AuthenticationHelper
    configure :development, :test do
      register Sinatra::Reloader
    end

    configure do
      set :environment => ENV.fetch('RACK_ENV').to_sym ||= :development
      set :root, File.realpath('.')
      set :public_folder => File.join(settings.root, 'public')
      set :haml, :layout => 'layouts/application'.to_sym, :escape_html => false
      set :views => File.join(settings.root, 'app/views')
      enable :sessions
    end
  end
end

# Load the controllers
Dir['./app/controllers/**/*.rb'].each { |f| require f }
