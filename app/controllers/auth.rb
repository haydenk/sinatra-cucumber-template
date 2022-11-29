module Template
  class App < BaseApp
    get '/login' do
      haml 'auth/login'.to_sym
    end

    post '/login' do
      env['warden'].authenticate!

      flash[:success] = "Successfully logged in"

      redirect '/'
    end

    get '/logout' do
      env['warden'].raw_session.inspect
      env['warden'].logout

      flash[:success] = "Successfully logged out"

      redirect '/'
    end

  end
end

