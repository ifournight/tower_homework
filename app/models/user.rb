class User < ApplicationRecord
  has_many :activities

  validates :name, presence: true
  validates :name, uniqueness: true

  validates :name, length: 4..15
end
