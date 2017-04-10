class Project < ApplicationRecord
  belongs_to :team
  belongs_to :creator, class_name: 'User'
  has_many :todos do
    def uncompleted
      where('completed = ?', false).order('edited_at DESC')
    end

    def completed
      where('completed = ?', true).order('edited_at DESC')
    end
  end

  def collaborators
    Access
      .where(
        subject_id: id,
        subject_type: self.class.name,
        access_type: Access::ACCESS_TYPE[:PROJECT_COLLABORATOR]
      ).map(&:user)
  end

  validates :name, presence: true
end
