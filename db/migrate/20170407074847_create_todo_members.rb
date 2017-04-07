class CreateTodoMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :todo_members do |t|
      t.references :member, index: true, null: false
      t.references :todo, index: true, null: false

      t.timestamps
    end
  end
end
