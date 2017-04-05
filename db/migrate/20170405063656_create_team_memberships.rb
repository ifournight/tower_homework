class CreateTeamMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :team_memberships do |t|
      t.references :team, index: true
      t.references :member, index: true
      t.string :member_authority

      t.timestamps
    end
    add_index :team_memberships, [:team_id, :member_id]
  end
end
