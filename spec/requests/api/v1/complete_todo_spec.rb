require 'rails_helper'

RSpec.describe 'POST /api/v1/complete_todos' do
  before :each do
    @user = create(:user)
    sign_in @user
    @project = create_logic_project(team_name: 'Citizen 4', project_name: 'journey', creator: @user)

    @todo = create_logic_todo(title: 'First todo', creator: @user, project: @project)
  end

  it 'completes the todo' do
    params = { user_id: @user.id, todo_id: @todo.id }
    post '/api/v1/complete_todos', params: { complete_todo: params }

    expect(response.status).to eq 200
    expect(@todo.reload.completed).to eq true
    expect(json_body['todo']['title']).to eq @todo.title
  end

  context 'post with invalid user id' do
    it 'return bad_request' do
      params = { user_id: -9999, todo_id: @todo.id }
      post '/api/v1/complete_todos', params: { complete_todo: params }

      expect(response.status).to eq 400
      expect(json_body['errors'].join).to match 'Invalid user ID'
    end
  end
end
