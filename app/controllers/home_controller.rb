class HomeController < ApplicationController
  def index
    @uncompleted_todos = Todo.where('completed = ?', false).order('edited_at DESC')
    @completed_todos = Todo.where('completed = ?', true).order('edited_at DESC')
    @create_todo = CreateTodo.new(creator_id: current_user.id)
  end
end
