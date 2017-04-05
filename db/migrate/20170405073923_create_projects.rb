class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :desc
      t.references :team, index: true

      t.timestamps
    end
    add_index :projects, :name
  end
end
