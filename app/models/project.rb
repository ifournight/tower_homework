class Project < ApplicationRecord
  belongs_to :team
  belongs_to :creator, class_name: 'User'
  has_many :todos

  def collaborators
    Access
      .where(
        subject_id: id,
        subject_type: self.class.name,
        access_type: Access::ACCESS_TYPE[:PROJECT_COLLABORATOR]
      ).to_a.map(&:user)
  end

  validates :name, presence: true
end
