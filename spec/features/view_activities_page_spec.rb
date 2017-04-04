require 'rails_helper'

RSpec.feature 'User view activities page' do
  scenario 'they see exsiting activities' do
    user = create(:user)
    activity = create(:activity)
    sign_in(user)

    visit sign_in_url
    visit activities_url

    a = activity
    expect(page).to have_css "#activity_#{a.id}"
  end
end
