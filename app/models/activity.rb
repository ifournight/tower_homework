class Activity < ApplicationRecord
  belongs_to :user

  ACTION_TYPES = {
    CREATE_TODO: 'create_todo',
    COMPLETE_TODO: 'complete_todo'
  }.freeze
end
