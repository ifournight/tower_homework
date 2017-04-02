# Provide helper methods about User authenticate
module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id unless user.nil?
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    session[:user_id] = nil
    current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
