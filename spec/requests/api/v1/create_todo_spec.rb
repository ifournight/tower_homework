require 'rails_helper'

RSpec.describe 'POST /api/v1/create_todos' do
  before :each do
    @user = create(:user)
    sign_in @user
  end

  it 'creates the link' do
    todo_params = build(:todo).attributes
    post '/api/v1/create_todos', params: { create_todo: todo_params }

    expect(response.status).to eq 201
    expect(Todo.last.title).to eq todo_params['title']
    expect(json_body['todo']['title']).to eq todo_params['title']
  end

  context 'when there are invalid attributes' do
    it 'returns a 422, with errors' do
      todo_params = attributes_for(:todo, :invalid)

      post '/api/v1/create_todos', params: { create_todo: todo_params }

      expect(response.status).to eq 422
      expect(json_body.fetch('errors')).not_to be_empty
    end
  end
end
