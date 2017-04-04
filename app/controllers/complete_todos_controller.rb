class CompleteTodosController < Todos::BaseController
  def create
    @complete_todo = CompleteTodo.new(complete_todo_params)
    @todo = @complete_todo.complete

    if @todo
      redirect_to root_path
    else
      render 'home/index'
    end
  end

  private

  def complete_todo_params
    params.require(:complete_todo).permit([:user_id, :todo_id])
  end
end
