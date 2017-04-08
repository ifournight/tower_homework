class ReopenTodo
  include ActiveModel::Model

  attr_accessor(
    :user_id,
    :todo_id,
    :status_code
  )

  def do
    errors[:user_id] << 'Invalid user ID' unless valid_user
    errors[:todo_id] << 'Invalid todo ID' unless valid_todo

    if any_errors?
      self.status_code = :bad_request
      return nil
    end

    @user = User.find(user_id)
    @todo = Todo.find(todo_id)

    errors[:todo_id] << "Can't edit deleted" if @todo.deleted
    errors[:todo_id] << "Can't reopen uncompleted" unless @todo.completed
    errors[:user_id] << "does't have access" unless check_user_access

    if any_errors?
      self.status_code = :method_not_allowed
      return nil
    end

    reopen_todo
    create_activity_reopen_todo
    @todo
  end

  private

  def any_errors?
    errors.each do |_key, _value|
      return true
    end
    false
  end

  def valid_user
    User.exists?(user_id)
  end

  def valid_todo
    Todo.exists?(todo_id)
  end

  def reopen_todo
    @todo.completed = false
    @todo.edited_at = Time.zone.now
    @todo.save
  end

  def check_user_access
    Access.has_access?(user_id, @todo.project.id, 'Project', Access::ACCESS_TYPE[:WRITE_PROJECT])
  end

  def create_activity_reopen_todo
    Activity.create(
      user_id: user_id,
      action: Activity::ACTION_TYPES[:REOPEN_TODO],
      subject_id: todo_id,
      subject_type: 'Todo',
      project_id: @todo.project.id
    )
  end
end
