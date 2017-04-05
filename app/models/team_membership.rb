class TeamMembership < ApplicationRecord
  belongs_to :member, class_name: 'User'
  belongs_to :team

  MEMBERSHIP_AUTHORITY = {
    SUPER_ADMIN: 'super_admin',
    ADMIN: 'admin',
    MEMBER: 'member',
    GUEST: 'guest'
  }

  validates :member_authority, presence: true
  validates :member_authority, inclusion: { in: MEMBERSHIP_AUTHORITY.values }
end
