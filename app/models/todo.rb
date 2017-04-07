class Todo < ApplicationRecord
  belongs_to :creator, class_name: 'User', optional: true
  belongs_to :project

  has_many :todo_members
  has_many :members, through: :todo_members

  validates :title, presence: true

  def over_due?
    return deadline < Time.zone.now unless deadline.nil?

    false
  end

  def assigned_member
    members.any? ? members[0] : nil
  end
end
