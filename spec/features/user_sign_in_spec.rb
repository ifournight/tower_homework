
require 'rails_helper'

RSpec.describe 'user sign in' do
  scenario 'get redirect_to activities page' do
    user = create(:user)
    activity = create(:activity)
    a = activity

    visit sign_in_url
    within "#new_sign_in" do
      fill_in 'sign_in_name', with: user.name
      click_on 'Sign in!'
    end

    expect(page).to have_css "#activity_#{a.id}",
                             text: "user #{a.user_id} #{a.action} #{a.subject_type} #{a.subject_id}"
  end
end
