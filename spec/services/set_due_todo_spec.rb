require 'rails_helper'

RSpec.describe SetDueTodo, '#do' do
  before :each do
    @user = create(:user)
    team = create(:team, owner: @user)
    project = create(:project, team: team, creator: @user)
    give_user_write_project_access(@user, project)
    @todo = create(:todo, project: project, creator: @user, title: 'wair for setting due')
    @due_date = '2017-04-09'
    @set_due_todo = SetDueTodo.new(user_id: @todo.creator.id,
                                   due_date: @due_date,
                                   todo_id: @todo.id)
  end

  it 'set todo a due' do
    @set_due_todo.do
    @todo.reload

    expect(@todo.deadline.to_s).to match @due_date
  end

  it 'create activity set due' do
    @set_due_todo.do
    activity = Activity.last

    expect(activity.action).to eq Activity::ACTION_TYPES[:SET_DUE_TODO]
  end
end
