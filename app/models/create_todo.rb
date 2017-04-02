# 负责创建ToDo，已经创建ToDo所涉及的其他业务逻辑
class CreateTodo
  include ActiveModel::Model

  attr_accessor(
    :title,
    :creator_id
  )

  validates :title, presence: true

  def create
    if valid?
      @todo = create_todo
      create_activity_create_todo

      @todo
    end
  end

  private

  def create_todo
    @todo = Todo.create(
      title: title,
      creator_id: creator_id
    )
  end

  def create_activity_create_todo
    Activity.create(
      user_id: creator_id,
      action: Activity::ACTION_TYPES[:CREATE_TODO],
      subject_id: @todo.id,
      subject_type: 'Todo'
    )
  end
end
