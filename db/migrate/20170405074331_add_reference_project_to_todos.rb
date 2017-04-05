class AddReferenceProjectToTodos < ActiveRecord::Migration[5.0]
  def change
    add_reference :todos, :project, index: true, foreign_key: true
  end
end
