class AddTeamMember
  include ActiveModel::Model

  attr_accessor(
    :team_id,
    :authorizer_id,
    :member_id,
    :member_authority
  )

  validates :team_id, presence: true
  validates :authorizer_id, presence: true
  validates :member_id, presence: true
  validates :member_authority, presence: true
  validates :member_authority, inclusion: { in: TeamMembership::MEMBERSHIP_AUTHORITY.values }

  def do
    return nil if invalid?
    unless valid_team
      errors[:team_id] << 'Invalid team id'
      nil
    end
    unless valid_user(member_id)
      errors[:member_id] << 'Invalid memeber id'
      nil
    end
    unless valid_user(authorizer_id)
      errors[:authorizer_id] << 'Invalid authorizer_id'
    end

    @user = User.find(member_id)
    @authorizer = User.find(authorizer_id)
    @team = Team.find(team_id)

    if @team.members.include?(@user)
      errors[:member_id] << 'already a member'
      nil
    end

    unless check_authorizer_access
      errors[:authorizer_id] << "Authorizer doesn't have acess to add member"
      nil
    end

    add_team_member
    authority_team_memeber

    @user
  end

  def valid_team
    true
  end

  def valid_user(_user_id)
    true
  end

  def check_authorizer_access
    unless Access.has_access?(authorizer_id, team_id, 'Team', Access::ACCESS_TYPE[:TEAM_MEMBER_MANAGE])
      errors[:authorizer_id] <<
        "Authorizer(User) #{@authorizer.name} don't have access to add a member in team #{@team.name}."
      false
    end
    true
  end

  def add_team_member
    TeamMembership.create(
      team_id: team_id,
      member_id: member_id,
      member_authority: member_authority
    )
  end

  def authority_team_memeber
    accesses = []
    case member_authority
    when TeamMembership::MEMBERSHIP_AUTHORITY[:ADMIN]
      accesses = Access::ACCESS_GROUP_ADMIN[:TEAM]
    when TeamMembership::MEMBERSHIP_AUTHORITY[:MEMBER]
      accesses = Access::ACCESS_GROUP_MEMBER[:TEAM]
    when TeamMemberShip::MEMBERSHIP_AUTHORITY[:GUEST]
      accesses = Access::ACCESS_GROUP_GUEST[:TEAM]
    end

    accesses.each do |access_type|
      Access.create(
        user_id: member_id,
        subject_id: @team.id,
        subject_type: @team.class.name,
        access_type: access_type
      )
    end
  end
end
