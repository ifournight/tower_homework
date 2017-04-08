class SignIn
  include ActiveModel::Model
  include SessionsHelper

  attr_accessor(:name)

  validates :name, presence: true
  validate :user_valid

  def sign_in
    if valid?
      @user
    else
      nil
    end
  end

  private

  def user_valid
    @user = User.find_by(name: name)

    if @user.nil?
      errors[:base] << '无效的用户名'
      return false
    end
  end
end
