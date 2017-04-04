require 'rails_helper'

RSpec.feature 'User create a new todo' do
  before :each do
    @user = create(:user, name: 'ifournight')
    sign_in @user

    @todo_title = 'First todo'

    visit root_url
    within '#new_create_todo' do
      fill_in 'create_todo_title', with: @todo_title
      click_on '创建任务'
    end
  end

  scenario 'he/she see the created todo' do
    expect(page).to have_content, @todo_title
  end

  scenario 'he/she visit activities page, see the related activity' do

    visit activities_path

    activity = Activity.last
    expect(page).to have_css "#activity_#{activity.id}"
  end
end
