class User < ApplicationRecord
  has_many :activities
  has_many :team_memberships, foreign_key: 'member_id'
  has_many :owned_teams, class_name: 'Team', foreign_key: 'owner_id'
  has_many :joined_teams, through: :team_memberships, source: :team
  has_many :todo_members, foreign_key: 'member_id'
  has_many :working_todos, through: :todo_members, source: :todo

  validates :name, presence: true
  validates :name, uniqueness: true

  validates :name, length: 4..15

  def anticipated_projects_in_team(team)
    ProjectCollaboratorQuery.new.find_user_anticipated_projects_in_team(self, team)
  end
end
