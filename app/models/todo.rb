class Todo < ApplicationRecord
  belongs_to :creator, class_name: 'User', optional: true
  belongs_to :project
  
  validates :title, presence: true
end
