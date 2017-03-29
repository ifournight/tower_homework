class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.integer :user_id, null: false
      t.string :action, null: false
      t.string :subject_type, null: false
      t.integer :subject_id, null: false

      t.timestamps
    end
    add_index :activities, :user_id
    add_index :activities, :subject_type
    add_index :activities, :subject_id
  end
end
