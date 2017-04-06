# 负责创建团队的业务逻辑
class CreateTeam
  include ActiveModel::Model

  attr_accessor(
    :creator_id,
    :team_name,
    :status_code
  )

  validates :team_name, presence: true

  def do
    errors[:creator_id] << 'Invalid Creator id' unless valid_user

    if any_errors?
      self.status_code = :bad_request
      return nil
    end

    # Check user has access to create team?

    if invalid?
      if errors[:team_name].any?
        self.status_code = :method_not_allowed
        return nil
      end
      return nil
    end

    @user = User.find(creator_id)
    @team = create_team
    make_creator_superadmin
    # notify ?
    # mailer ?

    @team
  end

  private

  def any_errors?
    errors.each do |_key, _value|
      return true
    end
    false
  end

  def valid_user
    User.exists?(creator_id)
  end


  def create_team
    Team.create(
      owner_id: creator_id,
      name: team_name
    )
  end

  def make_creator_superadmin
    TeamMembership.create(
      team_id: @team.id,
      member_id: @user.id,
      member_authority: TeamMembership::MEMBERSHIP_AUTHORITY[:SUPER_ADMIN]
    )

    # use prefabed access group to batchly factory accesses
    Access::ACCESS_GROUP_SUPERADMIN.each do |access_type|
      Access.create(
        user_id: creator_id,
        subject_id: @team.id,
        subject_type: @team.class.name,
        access_type: access_type
      )
    end
  end
end
