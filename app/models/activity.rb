class Activity < ApplicationRecord
  belongs_to :user

  ACTION_TYPES = {
    COMPLETE_TODO: 'complete_todo'
  }.freeze
end
