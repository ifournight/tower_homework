class Todo < ApplicationRecord
  belongs_to :creator, class_name: 'User', optional: true

  validates :title, presence: true
end
