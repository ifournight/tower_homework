class Team < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :team_memberships
  has_many :members, through: :team_memberships

  validates :name, presence: true
end
