class AddExtraToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :extra, :string
  end
end
