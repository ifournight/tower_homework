require 'rails_helper'

RSpec.describe CreateProject, '#do' do
  it 'Creat the project, make creator the collaborator' do
    user = create(:user)
    team = CreateTeam.new(
      creator_id: user.id,
      team_name: 'Hero 6'
    ).do
    create_project = CreateProject.new(
      creator_id: user.id,
      team_id: team.id,
      desc: '',
      project_name: 'V coming'
    )
    user = user.reload

    project = create_project.do
    collaborators = project.collaborators

    expect(project.team.id).to eq team.id
    expect(project.creator.id).to eq user.id
    expect(collaborators.include?(user)).to eq true
    Access::ACCESS_GROUP_MEMBER[:PROJECT].each do |access_type|
      expect(Access.has_access?(user.id, project.id, project.class.name, access_type)).to eq true
    end
    Access::ACCESS_GROUP_PROJECT_MANAGER[:PROJECT].each do |access_type|
      expect(Access.has_access?(user.id, project.id, project.class.name, access_type)).to eq true
    end

  end
end
