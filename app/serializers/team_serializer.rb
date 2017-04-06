class TeamSerializer < ActiveModel::Serializer
  class ProjectSerializer < ActiveModel::Serializer
    attributes :name, :id
  end
  
  class MemberSerializer < ActiveModel::Serializer
    attributes :id, :name
  end

  attributes :name, :owner_id, :created_at, :updated_at

  has_one :owner
  has_many :projects
  has_many :members, serializer: MemberSerializer
end
