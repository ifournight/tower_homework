class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true

  ACTION_TYPES = {
    CREATE_TODO: 'create_todo',
    COMPLETE_TODO: 'complete_todo',
    REOPEN_TODO: 'reopen_todo'
  }.freeze
end
