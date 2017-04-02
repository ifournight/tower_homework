class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

  before_action :user_signed_in?

  def user_signed_in?
    redirect_to sign_in_path, notice: '您必需首先登录才能继续' unless signed_in?
  end
end
