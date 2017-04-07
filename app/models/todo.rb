class Todo < ApplicationRecord
  belongs_to :creator, class_name: 'User', optional: true
  belongs_to :project

  validates :title, presence: true

  def over_due?
    unless deadline.nil?
      return deadline < Time.zone.now
    end

    false
  end
end
