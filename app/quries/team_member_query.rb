class TeamMemberQuery
  def find_team_super_admin(team, &block)
    find_given_type_team_member(
      team,
      TeamMembership::MEMBERSHIP_AUTHORITY[:SUPER_ADMIN],
      &block
    )
  end

  def fine_team_member(team, &block)
    find_given_type_team_member(
      team,
      TeamMembership::MEMBERSHIP_AUTHORITY[:MEMBER],
      &block
    )
  end

  private

  def find_given_type_team_member(team, member_authority)
    temp = TeamMembership
           .where(
             team_id: team.id,
             member_authority: member_authority
           )
           .to_a
    if block_given?
      temp.each do |membership|
        yield(membership.member)
      end
    else
      temp.map(&:member)
    end
  end
end
