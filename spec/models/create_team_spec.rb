require 'rails_helper'

RSpec.describe CreateTeam, '#do' do
  it 'Creat the team, make owner the superadmin, give all access to team' do
    user = create(:user)
    create_team = CreateTeam.new(
      creator_id: user.id,
      team_name: 'Hero 6'
    )

    team = create_team.do
    user = user.reload
    superadmin = TeamMemberQuery.new.find_team_super_admin(team)[0]

    expect(team.owner.id).to eq user.id
    expect(user.owned_teams.include?(team)).to eq true
    expect(superadmin.id).to eq user.id
    Access::ACCESS_GROUP_SUPERADMIN.each do |access_type|
      expect(Access.has_access?(user.id, team.id, team.class.name, access_type)).to eq true
    end
  end
end
