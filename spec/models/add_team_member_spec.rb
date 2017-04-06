require 'rails_helper'

RSpec.describe AddTeamMember, '#do' do
  it 'add member into the team' do
    team_owner = create(:user)
    user = create(:user)
    team = CreateTeam.new(
      creator_id: team_owner.id,
      team_name: 'Hero 6'
    ).do
    add_team_member = AddTeamMember.new(
      authorizer_id: team_owner.id,
      team_id: team.id,
      member_id: user.id,
      member_authority: TeamMembership::MEMBERSHIP_AUTHORITY[:MEMBER]
    )

    member = add_team_member.do
    user = user.reload
    members = TeamMemberQuery.new.fine_team_member(team)

    expect(member.id).to eq user.id
    expect(team.members.include?(user)).to eq true
    expect(members.include?(user)).to eq true
    Access::ACCESS_GROUP_MEMBER[:TEAM].each do |access_type|
      expect(Access.has_access?(user.id, team.id, team.class.name, access_type)).to eq true
    end
  end
end
