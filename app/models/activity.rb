class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true
  belongs_to :project

  serialize :extra, Hash

  ACTION_TYPES = {
    CREATE_TODO: 'create_todo',
    COMPLETE_TODO: 'complete_todo',
    REOPEN_TODO: 'reopen_todo',
    SET_DUE_TODO: 'set_due_todo'
  }.freeze
end
