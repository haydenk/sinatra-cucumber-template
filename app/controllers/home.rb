module Template
  class App < BaseApp
    get '/' do
      haml 'home/index'.to_sym
    end

    get '/dashboard' do
      env['warden'].authenticate!
      haml 'home/index'.to_sym
    end
  end
end
