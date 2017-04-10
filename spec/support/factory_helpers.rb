module FactoryHelpers
  def create_logic_team(team_name: 'Citizen 4', owner:)
    CreateTeam.new(
      team_name: team_name,
      creator_id: owner.id
    ).do
  end

  def create_logic_project(project_name: 'V coming',
                           creator:,
                           team_name: 'Citizen 4')
    team = create_logic_team(team_name: team_name, owner: creator)
    CreateProject.new(
      project_name: project_name,
      creator_id: creator.id,
      team_id: team.id
    ).do
  end

  def create_logic_todo(title: 'First Todo',
                        creator:,
                        project:)

    CreateTodo.new(
      project_id: project.id,
      creator_id: creator.id,
      title: title
    ).create
  end

  def add_team_member(team:, member:, authority:)
    AddTeamMember.new(
      team_id: team.id,
      member_id: member.id,
      member_authority: authority
    ).do
  end

  def give_user_write_project_access(user, project)
    Access.create(
      user_id: user.id,
      subject_id: project.id,
      subject_type: 'Project',
      access_type: Access::ACCESS_TYPE[:WRITE_PROJECT]
    )
  end
end

RSpec.configure do |config|
  config.include FactoryHelpers
end
