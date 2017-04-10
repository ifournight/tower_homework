require 'rails_helper'

RSpec.feature 'User create a new todo' do
  before :each do
    @user = create(:user, name: 'ifournight')
    @team_citizen_4 = create_logic_team(owner: @user, team_name: 'Citizen 4')
    @journey = create_logic_project_from_team(team: @team_citizen_4, project_name: 'journey', creator: @user)

    sign_in @user

    visit project_path(@journey)

    @todo_title = 'First todo'
  end

  scenario 'he/she see the created todo' do
    within '#new_create_todo' do
      fill_in 'create_todo_title', with: @todo_title
      click_on '创建任务'
    end

    expect(page).to have_content, @todo_title
  end

  context 'he/she submit empty titled todo' do
    scenario 'stayed in this page' do
      within '#new_create_todo' do
        fill_in 'create_todo_title', with: ''
        click_on '创建任务'
      end

      within '#new_create_todo' do
        expect(page).to have_content "can't be blank"
      end
    end
  end

  scenario 'he/she visit activities page, see the related activity' do
    within '#new_create_todo' do
      fill_in 'create_todo_title', with: @todo_title
      click_on '创建任务'
    end

    visit activities_path

    activity = Activity.last
    expect(page).to have_css "#activity_#{activity.id}"
  end
end
