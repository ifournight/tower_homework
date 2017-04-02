module SessionsHelpers
  def sign_in(user)
    if defined? page
      page.set_rack_session(user_id: user.id)
    else
      post sign_in_path, params: { sign_in: { name: user.name } }
    end
  end
end

RSpec.configure do |config|
  config.include SessionsHelpers, type: :request
  config.include SessionsHelpers, type: :feature
end
