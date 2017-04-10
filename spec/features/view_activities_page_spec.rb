require 'rails_helper'

RSpec.feature 'User view activities page' do
  before :each do
    @user = create(:user, name: 'ifournight')
    @momo = create(:user, name: 'momo')

    @team_citizen_4 = create_logic_team(owner: @user, team_name: 'Citizen 4')
    @team_private = create_logic_team(owner: @user, team_name: 'ifournight private')

    add_team_member(team: @team_citizen_4, member: @momo, authority: 'member')
    add_team_member(team: @team_private, member: @momo, authority: 'member')

    @journey = create_logic_project_from_team(team: @team_citizen_4, project_name: 'journey', creator: @user)
    @make_momo_star = create_logic_project_from_team(team: @team_citizen_4, project_name: 'make_momo_star', creator: @user)

    @v_coming = create_logic_project_from_team(team: @team_private, project_name: 'v_coming', creator: @user)
    @homework = create_logic_project_from_team(team: @team_private, project_name: 'tower_homework', creator: @user)

    make_user_project_collaborator(@momo, @make_momo_star)
    make_user_project_collaborator(@momo, @v_coming)
    make_user_project_collaborator(@momo, @homework)

    10.times do |i|
      create_logic_todo(creator: @user, project: @journey, title: "Todo #{i * 4 + 1}")
      create_logic_todo(creator: @user, project: @make_momo_star, title: "Todo #{i * 4 + 2}")
      create_logic_todo(creator: @user, project: @v_coming, title: "Todo #{i * 4 + 3}")
      create_logic_todo(creator: @user, project: @homework, title: "Todo #{i * 4 + 4}")
    end
  end

  scenario 'he/she only see exsiting activities belongs_to current working team' do
    visit sign_in_url
    sign_in(@momo)

    # let rails know user is working on this project
    visit project_path(@journey)
    visit activities_path

    expect(page).to have_current_path(activities_path)
    expect(page).to have_css "#activities-team_#{@journey.team.id}"
    expect(page).to have_no_css "#activities-team_#{@team_private.id}"
  end

  scenario 'he/she see activities belongs to projects only he/she anticipated' do
    sign_in(@momo)

    # let rails know user is working on this project
    visit project_path(@journey)
    visit activities_path

    expect(page).to have_css "#activities-team_#{@journey.team.id}"

    @make_momo_star.activities.each do |activity|
      expect(page).to have_css "#activity_#{activity.id}"
    end

    @journey.activities.each do |activity|
      expect(page).to have_no_css "#activity_#{activity.id}"
    end
  end
end
