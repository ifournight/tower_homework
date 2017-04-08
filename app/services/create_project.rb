class CreateProject
  include ActiveModel::Model

  validates :name, presence: true

  attr_accessor(
    :project_name,
    :desc,
    :team_id,
    :creator_id
  )

  def do
    unless user_valid?
      errors[:creator_id] << 'Invalid Creator ID'
      return nil
    end
    unless team_valid?
      errors[:team_id] << 'Invalid Team Invalid'
      return nil
    end

    @user = User.find(creator_id)
    @team = Team.find(team_id)

    return nil unless check_user_access

    @project = create_project
    make_creator_collaborator
    @project
  end

  private

  def user_valid?
    true
  end

  def team_valid?
    true
  end

  def check_user_access
    unless @team.members.include?(@user)
      errors[:creator_id] <<
        "Creator(User) #{@user.name} can't create project being not a memeber of team #{@team.name}."
      return false
    end

    unless Access.has_access?(creator_id, team_id, 'Team', Access::ACCESS_TYPE[:CREATE_TEAM_PROJECTS])
      errors[:creator_d] <<
        "Creator(User) #{@user.name} don't have access to create a project."
      return false
    end

    true
  end

  def create_project
    Project.create(
      creator_id: creator_id,
      name: project_name,
      desc: desc,
      team_id: team_id
    )
  end

  def make_creator_collaborator
    accesses = Access::ACCESS_GROUP_MEMBER[:PROJECT]
               .dup
               .concat(Access::ACCESS_GROUP_PROJECT_MANAGER[:PROJECT].dup)
    accesses.each do |access_type|
      Access.create(
        user_id: @user.id,
        subject_id: @project.id,
        subject_type: @project.class.name,
        access_type: access_type
      )
    end
  end
end
