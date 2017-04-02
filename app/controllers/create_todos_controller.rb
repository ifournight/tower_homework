class CreateTodosController < Todos::BaseController
  def create
    @create_todo = CreateTodo.new(create_todo_params)
    @new_todo = @create_todo.create

    if @new_todo
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js {}
      end
    else
      respond_to do |format|
        format.html do
          @todos = Todo.order('created_at DESC')
          render 'home/index'
        end
        format.js {}
      end
    end
  end

  private

  def create_todo_params
    params.require(:create_todo).permit([:title, :creator_id])
  end
end
