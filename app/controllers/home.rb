module Template
  class App < BaseApp
    get '/' do
      if env['warden'].user
        redirect '/dashboard'
      end
      haml 'home/index'.to_sym
    end

    get '/dashboard' do
      env['warden'].authenticate!
      haml 'home/dashboard'.to_sym
    end
  end
end
