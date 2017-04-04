class CompleteTodo
  include ActiveModel::Model

  attr_accessor(
    :user_id,
    :todo_id,
    :status_code
  )

  def complete
    errors[:user_id] << 'Invalid user ID' unless valid_user
    errors[:todo_id] << 'Invalid todo ID' unless valid_todo

    if any_errors?
      self.status_code = :bad_request
      return nil
    end

    @user = User.find(user_id)
    @todo = Todo.find(todo_id)

    errors[:todo_id] << "Can't edit deleted" if @todo.deleted
    errors[:todo_id] << "Can't complete completed" if @todo.completed

    if any_errors?
      self.status_code = :method_not_allowed
      return nil
    end

    complete_todo
    create_activity_complete_todo
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

  def complete_todo
    @todo.completed = true
    @todo.edited_at = Time.zone.now
    @todo.save
  end

  def create_activity_complete_todo
    Activity.create(
      user_id: user_id,
      action: Activity::ACTION_TYPES[:COMPLETE_TODO],
      subject_id: todo_id,
      subject_type: 'Todo'
    )
  end
end
