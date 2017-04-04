require 'rails_helper'

RSpec.describe CompleteTodo, '#create' do
  context 'with valid params' do
    it 'complete todo and create related activity' do
      todo = create(:todo)
      complete_todo = CompleteTodo.new(user_id: todo.creator.id,
                                       todo_id: todo.id)

      complete_todo.complete
      activity = Activity.last
      todo = todo.reload

      expect(todo.completed).to eq true
      expect(activity.subject_id).to eq todo.id
      expect(activity.subject_type).to eq 'Todo'
      expect(activity.action).to eq Activity::ACTION_TYPES[:COMPLETE_TODO]
    end
  end

  context 'with invalid user_id' do
    it 'return nil and fill errors in field user_id' do
      user_id = -9999
      todo = double(id: 1, deleted: false, completed: false)

      complete_todo = CompleteTodo.new(user_id: user_id,
                                       todo_id: todo.id)
      allow(complete_todo).to receive(:valid_todo).and_return(true)

      result = complete_todo.complete

      expect(result).to eq nil
      expect(complete_todo.errors[:user_id].join).to eq 'Invalid user ID'
    end
  end

  context 'with invalid todo_id' do
    it 'return nil and fill errors in field todo_id' do
      user = double(id: 1)
      todo_id = -9999
      complete_todo = CompleteTodo.new(user_id: user.id,
                                       todo_id: todo_id)
      allow(complete_todo).to receive(:valid_user).and_return(true)

      result = complete_todo.complete

      expect(result).to eq nil
      expect(complete_todo.errors[:todo_id].join).to eq 'Invalid todo ID'
    end
  end

  context 'with deleted todo_id' do
    it 'return nil and fill errors in field todo_id' do
      user = double(id: 1)
      todo = double(id: 1)
      complete_todo = CompleteTodo.new(user_id: user.id,
                                       todo_id: todo.id)
      allow(complete_todo).to receive(:valid_user).and_return(true)
      allow(complete_todo).to receive(:valid_todo).and_return(true)
      allow(User).to receive(:find).and_return(user)
      allow(Todo).to receive(:find).and_return(todo)
      allow(todo).to receive(:deleted).and_return(true)
      allow(todo).to receive(:completed).and_return(false)

      result = complete_todo.complete

      expect(result).to eq nil
      expect(complete_todo.errors[:todo_id].join).to eq "Can't edit deleted"
    end
  end

  context 'with completed todo_id' do
    it 'return nil and fill errors in field todo_id' do
      user = double(id: 1)
      todo = double(id: 1)
      complete_todo = CompleteTodo.new(user_id: user.id,
                                       todo_id: todo.id)
      allow(complete_todo).to receive(:valid_user).and_return(true)
      allow(complete_todo).to receive(:valid_todo).and_return(true)
      allow(User).to receive(:find).and_return(user)
      allow(Todo).to receive(:find).and_return(todo)
      allow(todo).to receive(:deleted).and_return(false)
      allow(todo).to receive(:completed).and_return(true)

      result = complete_todo.complete

      expect(result).to eq nil
      expect(complete_todo.errors[:todo_id].join).to eq "Can't complete completed"
    end
  end
end
