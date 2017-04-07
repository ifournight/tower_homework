class TodoMember < ApplicationRecord
  belongs_to :member, class_name: 'User'
  belongs_to :todo
end
