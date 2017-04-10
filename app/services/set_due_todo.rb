class SetDueTodo
  include ActiveModel::Model

  attr_accessor(
    :user_id,
    :todo_id,
    :due_date,
    :status_code
  )

  validates :user_id, presence: true
  validates :todo_id, presence: true
  validates :due_date, presence: true
  validate  :valid_due_date

  def do
    return nil if invalid?

    # check user valid
    # check todo valid
    @user = User.find(user_id)
    @todo = Todo.find(todo_id)

    unless check_user_access
      errors.add(:user_id, "doesn't have access")
      return nil
    end

    create_activity
    set_due
  end

  private

  def valid_due_date
    errors.add(:due_date, 'must be a valid datetime') if (begin
      DateTime.parse(due_date)
    rescue
      ArgumentError
    end) == ArgumentError
  end

  def valid_user
    errors.add(:user_id, 'must be valid') unless User.exists?(user_id)
  end

  def valid_todo
    errors.add(:todo_id, 'must be valid') unless Todo.exists?(todo_id)
  end

  def check_user_access
    Access.has_access?(user_id, @todo.project.id, 'Project', Access::ACCESS_TYPE[:WRITE_PROJECT])
  end

  def create_activity
    Activity.create(
      user_id: user_id,
      action: Activity::ACTION_TYPES[:SET_DUE_TODO],
      subject_id: todo_id,
      subject_type: @todo.class.name,
      project_id: @todo.project.id,
      extra: { due_change_from: @todo.deadline.to_s, due_change_to: DateTime.parse(due_date).to_s }
    )
  end

  def set_due
    @todo.deadline = DateTime.parse(due_date)
    @todo.save!
  end
end
