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

    post '/unauthenticated' do
      session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?

      # Set the error and use a fallback if the message is not defined
      flash[:error] = env['warden.options'][:message] || "You must log in"
      redirect '/login'
    end
  end
end

