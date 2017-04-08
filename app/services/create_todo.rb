# 负责创建ToDo，已经创建ToDo所涉及的其他业务逻辑
class CreateTodo
  include ActiveModel::Model

  attr_accessor(
    :title,
    :project_id,
    :creator_id
  )

  validates :project_id, presence: true
  validates :creator_id, presence: true
  validates :title, presence: true

  def create
    return nil if invalid?

    # valid creator
    # valid project

    @creator = User.find(creator_id)

    unless check_user_access
      errors[:creator_id] << "Creator #{creator_id} doesn't have access to create a todo in this project."
      return nil
    end

    @todo = create_todo
    create_activity_create_todo

    @todo
  end

  private

  def create_todo
    @todo = Todo.create(
      title: title,
      creator_id: creator_id,
      project_id: project_id
    )
  end

  def check_user_access
    Access.has_access?(creator_id, project_id, 'Project', Access::ACCESS_TYPE[:WRITE_PROJECT])
  end

  def create_activity_create_todo
    Activity.create(
      user_id: creator_id,
      action: Activity::ACTION_TYPES[:CREATE_TODO],
      subject_id: @todo.id,
      subject_type: 'Todo',
      project_id: project_id
    )
  end
end
