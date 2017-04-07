class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @uncompleted_todos = @project.todos.uncompleted
    @completed_todos = @project.todos.completed

    @create_todo = CreateTodo.new(creator_id: current_user.id, project_id: @project.id)

    session[:team_id] = @project.team.id
  end
end
