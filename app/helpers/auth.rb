module AuthenticationHelper
  def authenticate!
    unless logged_in?
      session[:original_request] = request.path_info
      redirect to "/login"
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user #help with keeping code dry
    User.find_by(id: session[:user_id])
  end
end

