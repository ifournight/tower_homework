class CreateAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :accesses do |t|
      t.references :user, index: true
      t.integer :subject_id
      t.string  :subject_type
      t.string :type, null: false, index: true
      t.timestamps
    end

    add_index :accesses, [:subject_id, :subject_type]
    add_index :accesses, [:user_id, :subject_id, :subject_type, :type],
              name: 'has access index', unique: true
  end
end
