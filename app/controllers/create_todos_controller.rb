class CreateTodosController < Todos::BaseController
  def create
    create_todo = CreateTodo.new(create_todo_params)
    todo = create_todo.create
    if todo
      redirect_to root_url, notice: 'Todo created successfully.'
    else
      render 'home#index'
    end
  end

  private

  def create_todo_params
    params.require(:create_todo).permit([:title, :creator_id])
  end
end
