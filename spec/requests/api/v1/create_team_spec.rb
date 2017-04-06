require 'rails_helper'

RSpec.describe 'POST /api/v1/create_teams' do
  before :each do
    @user = create(:user)
    sign_in @user
  end

  it 'completes the todo' do
    team_name = 'Citizen 4'
    params = { creator_id: @user.id, team_name: team_name }
    post '/api/v1/create_teams', params: { create_team: params }
    team = Team.find_by(name: team_name)

    expect(response.status).to eq 201
    expect(@user.reload.owned_teams.include?(team)).to eq true
    debugger
    expect(json_body['team']['name']).to eq team.name
  end

  context 'post with invalid user id' do
    it 'return bad_request' do
      team_name = 'Citizen 4'
      params = { creator_id: -9999, team_name: team_name }
      post '/api/v1/create_teams', params: { create_team: params }

      expect(response.status).to eq 400
      expect(json_body['errors'].join).to match 'Invalid Creator id'
    end
  end
end
