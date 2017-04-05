class Access < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true

  ACCESS_TYPE = {
    PROJECT_COLLABORATOR: 'access_type_project_collaborator',
    CREATE_PROJECT: 'access_type_create_project',
    DELETE_PROJECT: 'access_type_delete_project',
    READ_PROJECT: 'access_type_read_project',
    WRITE_PROJECT: 'access_type_write_project',
    INVITE_JOIN_TEAM: 'access_type_invite_join_team',
    TEAM_MEMBER_MANAGE: 'access_type_team_member_manage',
    TEAM_MEMBER_AUTHORITY_MANAGE: 'access_type_team_member_authority_manage',
    SLACK_LINKING: 'access_type_slack_linking'
  }.freeze

  validates :type, presence: true
  validates :type, inclusion: { in: ACCESS_TYPE.values }

  def self.has_access?(user_id, subject_id, subject_type, access_type)
    return true if where(user_id: user_id,
                         subject_id: subject_id,
                         subject_type: subject_type,
                         type: access_type).any?
    false
  end
end
