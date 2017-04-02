class SignInController < ApplicationController
  skip_before_action :user_signed_in?, only: [:new, :create]

  def new
    @sign_in = SignIn.new
  end

  def create
    @sign_in = SignIn.new(sign_in_params)
    user = @sign_in.sign_in

    if user
      sign_in(user)
      redirect_to activities_path
    else
      render :new
    end
  end

  private

  def sign_in_params
    params.require(:sign_in).permit(:name)
  end
end
