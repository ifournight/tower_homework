class CreateTodosController < Todos::BaseController
  def create
    @create_todo = CreateTodo.new(create_todo_params)
    @new_todo = @create_todo.create

    if @new_todo
      respond_to do |format|
        format.html { redirect_to project_path(@new_todo) }
        format.js {}
      end
    else
      respond_to do |format|
        format.html do
          project = Project.find(@create_todo.project_id)
          @uncompleted_todos = project.todos.uncompleted
          @completed_todos = project.todos.completed
          render 'projects/show'
        end
        format.js {}
      end
    end
  end

  private

  def create_todo_params
    params.require(:create_todo).permit([:title, :creator_id, :project_id])
  end
end
