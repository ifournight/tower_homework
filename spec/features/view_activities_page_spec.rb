require 'rails_helper'

RSpec.feature 'User view activities page' do
  scenario 'they see exsiting activities' do
    activity = Activity.create(
      user_id: 2,
      action: 'complete_todo',
      subject_type: 'Todo',
      subject_id: 2
    )

    visit activities_url

    a = activity
    expect(page).to have_css "#activity_#{a.id}",
                             text: "user #{a.user_id} #{a.action} #{a.subject_type} #{a.subject_id}"
  end
end
