class Access < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true

  ACCESS_TYPE = {
    PROJECT_COLLABORATOR: 'at_project_collaborator', #特殊：标记加入Project
    DELETE_PROJECT: 'at_delete_project', # 删除指定Project
    READ_PROJECT: 'at_read_project', # 只读Project
    WRITE_PROJECT: 'at_write_project', # 在Project中创建（任务等...
    PROJECT_COLLABORATOR_MANAGE: 'at_projecdt_collaborator_manage',

    CREATE_TEAM_PROJECTS: 'at_create_projects', # 在团队中创建Project
    DELETE_TEAM_PROJECTS: 'at_delete_projects', #在团队中删除任意Project
    INVITE_JOIN_TEAM: 'at_invite_join_team', #邀请新的成员
    TEAM_MEMBER_MANAGE: 'at_team_member_manage', #成员管理：包括新加／删除成员，管理成员参与的Project
    TEAM_MEMBER_AUTHORITY_MANAGE: 'at_team_member_authority_manage', #成员权限管理
    READ_TEAM_MEMBER: 'at_read_team_memeber'
  }.freeze

  AT = ACCESS_TYPE

  ACCESS_GROUP_PROJECT_MANAGER = {
    PROJECT:
    [
      AT[:PROJECT_COLLABORATOR_MANAGE]
    ]
  }.freeze

  ACCESS_GROUP_GUEST = {
    TEAM: [],
    PROJECT:
    [
      AT[:PROJECT_COLLABORATOR],
      AT[:READ_PROJECT],
      AT[:WRITE_PROJECT]
    ]
  }.freeze

  ACCESS_GROUP_MEMBER = {
    TEAM:
    [
      AT[:INVITE_JOIN_TEAM],
      AT[:CREATE_TEAM_PROJECTS],
      AT[:READ_TEAM_MEMBER]
    ],
    PROJECT:
    [
      AT[:PROJECT_COLLABORATOR],
      AT[:READ_PROJECT],
      AT[:WRITE_PROJECT],
      AT[:DELETE_PROJECT]
    ]
  }.freeze

  ACCESS_GROUP_ADMIN = ACCESS_GROUP_MEMBER.deep_merge(
  TEAM:
  [
    AT[:INVITE_JOIN_TEAM],
    AT[:CREATE_TEAM_PROJECTS],
    AT[:READ_TEAM_MEMBER],
    AT[:TEAM_MEMBER_MANAGE],
    AT[:TEAM_MEMBER_AUTHORITY_MANAGE]
  ]
  ).freeze

  ACCESS_GROUP_SUPERADMIN = ACCESS_GROUP_ADMIN.deep_merge(
  TEAM:
  [
    AT[:INVITE_JOIN_TEAM],
    AT[:CREATE_TEAM_PROJECTS],
    AT[:READ_TEAM_MEMBER],
    AT[:TEAM_MEMBER_MANAGE],
    AT[:TEAM_MEMBER_AUTHORITY_MANAGE],
    AT[:DELETE_TEAM_PROJECTS]
  ]
  ).freeze

  validates :access_type, presence: true
  validates :access_type, inclusion: { in: ACCESS_TYPE.values }

  def self.has_access?(user_id, subject_id, subject_type, access_type)
    return true if where(user_id: user_id,
                         subject_id: subject_id,
                         subject_type: subject_type,
                         access_type: access_type).any?
    false
  end
end
