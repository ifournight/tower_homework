class Api::V1::CreateTodosController < ApplicationController
  def create
    @create_todo = CreateTodo.new(create_todo_params)
    todo = @create_todo.create
    if todo
      render json: todo, status: :created
    else
      render json: { errors: @create_todo.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def create_todo_params
    params.require(:create_todo).permit([:title, :creator_id])
  end
end
