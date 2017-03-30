class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :deadline, :created_at, :edited_at
end
