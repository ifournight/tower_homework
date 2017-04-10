class ReopenTodosController < Todos::BaseController
  def create
    @reopen_todo = ReopenTodo.new(reopen_todo_params)
    @todo = @reopen_todo.do

    if @todo
      redirect_to project_path(@todo.project)
    end
  end

  private

  def reopen_todo_params
    params.require(:reopen_todo).permit([:user_id, :todo_id])
  end
end
