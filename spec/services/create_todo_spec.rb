require 'rails_helper'

RSpec.describe CreateTodo, '#validations' do
  it { is_expected.to validate_presence_of :title }
end

RSpec.describe CreateTodo, '#create' do
  context 'when valid' do
    it 'call create_todo and create_activity_create_todo' do
      user = create(:user)
      team = CreateTeam.new(
        team_name: 'Citizen 4',
        creator_id: user.id
      ).do
      project = CreateProject.new(
        creator_id: user.id,
        team_id: team.id,
        project_name: 'V coming'
      ).do
      create_params = {
        title: 'First todo',
        creator_id: user.id,
        project_id: project.id
      }
      todo = double(save: true, id: 1, project: 1)
      activity_params = {
        user_id: user.id,
        action: Activity::ACTION_TYPES[:CREATE_TODO],
        subject_id: todo.id,
        subject_type: 'Todo',
        project_id: project.id
      }
      create_todo = CreateTodo.new(create_params)
      allow(Todo).to receive(:create).and_return(todo)
      allow(Activity).to receive(:create).and_return(nil)

      create_todo.create

      expect(Todo).to have_received(:create).with(create_params)
      expect(Activity).to have_received(:create).with(activity_params)
    end
  end
end
