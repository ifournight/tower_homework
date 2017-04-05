class Project < ApplicationRecord
  belongs_to :team
  belongs_to :creator, class_name: 'User'
  has_many :todos

  validates :name, presence: true
end
