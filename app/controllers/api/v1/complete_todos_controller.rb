class Api::V1::CompleteTodosController < ApplicationController
  def create
    @complete_todo = CompleteTodo.new(complete_todo_params)
    todo = @complete_todo.complete
    if todo
      render json: todo, status: :ok
    else
      render json: { errors: @complete_todo.errors.full_messages },
             status: @complete_todo.status_code
    end
  end

  private

  def complete_todo_params
    params.require(:complete_todo).permit([:user_id, :todo_id])
  end
end
