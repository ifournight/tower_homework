class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.references :creator, index: true
      t.string :title, null: false
      t.text :description
      t.boolean :completed, default: false
      t.boolean :deleted, default: false
      t.datetime :deadline
      t.datetime :edited_at
      t.timestamps
    end
  end
end
