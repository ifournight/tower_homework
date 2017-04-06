class RenameTypeOnAccesses < ActiveRecord::Migration[5.0]
  def change
    rename_column :accesses, :type, :access_type
  end
end
