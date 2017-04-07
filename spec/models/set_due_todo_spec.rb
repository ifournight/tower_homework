require 'rails_helper'

RSpec.describe SetDueTodo, '#do' do
  before :each do
    @todo = create(:todo, title: 'wair for setting due')
    @due_date = '2017-04-09'
    Access.create(
      user_id: @todo.creator_id,
      subject_id: @todo.project.id,
      subject_type: 'Project',
      access_type: Access::ACCESS_TYPE[:WRITE_PROJECT]
    )
    @set_due_todo = SetDueTodo.new(user_id: @todo.creator.id,
                                   due_date: @due_date,
                                   todo_id: @todo.id)
  end

  it 'set todo a due' do
    @set_due_todo.do
    @todo = @todo.reload

    expect(@todo.deadline.to_s).to match @due_date
  end

  context 'if todo has no due before' do
    it 'create activity create due' do
      @set_due_todo.do
      activity = Activity.last

      expect(activity.action).to eq Activity::ACTION_TYPES[:CREATE_DUE_TODO]
    end
  end

  context 'if todo has due before' do
    it 'create activity set due' do
      @set_due_todo.do

      SetDueTodo.new(user_id: @todo.creator.id,
                     due_date: '2017-04-18',
                     todo_id: @todo.id).do

      activity = Activity.last

      expect(activity.action).to eq Activity::ACTION_TYPES[:SET_DUE_TODO]
    end
  end
end
