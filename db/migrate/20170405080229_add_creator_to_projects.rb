class AddCreatorToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :creator, index: true, foreign_key: true
  end
end
