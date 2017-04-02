class HomeController < ApplicationController
  def index
    @todos = Todo.order('created_at DESC')
    @create_todo = CreateTodo.new(creator_id: current_user.id)
  end
end
