class AssignTodo
  include ActiveModel::Model

  attr_accessor(
    :todo_id,
    :authorizer_id,
    :member_id
  )

  validates_presence_of [:todo_id, :authorizer_id, :member_id]
  validate :valid_todo_id
  validate :valid_authorizer_id
  validate :valid_member_id

  def do
    return nil if invalid?

    valid_todo_id
    valid_authorizer_id
    valid_member_id

    @authorizer = User.find(authorizer_id)
    @member = User.find(member_id)
    @todo = Todo.find(todo_id)

    return nil if any_errors?

    check_authorizer_access
    check_already_member

    return nil if any_errors?

    assign_todo
    create_activity_assign_todo
    @todo
  end

  private

  def any_errors?
    errors.each do |_key, _value|
      return true
    end
    false
  end

  def valid_todo_id
    errors.add(:todo_id, 'must be valid') unless Todo.exists?(todo_id)
  end

  def valid_authorizer_id
    errors.add(:authorizer_id, 'must be valid') unless User.exists?(authorizer_id)
  end

  def valid_member_id
    errors.add(:member_id, 'must be valid') unless User.exists?(member_id)
  end

  def check_authorizer_access
    errors.add(:authorizer_id, "doesn't have access") unless Access.has_access?(
      @authorizer.id,
      @todo.project.id,
      @todo.project.class.name,
      Access::ACCESS_TYPE[:WRITE_PROJECT]
    )
  end

  def check_already_member
    errors.add(:member_id, 'already assigned') if @todo.members.any? && @todo.members.include?(@member)
  end

  def create_activity_assign_todo
    Activity.create(
      user_id: authorizer_id,
      subject_id: todo_id,
      subject_type: @todo.class.name,
      action: Activity::ACTION_TYPES[:ASSIGN_TODO],
      project_id: @todo.project_id,
      extra: { member_from_id: @member_from ? @member_from.id : '', member_to_id: member_id }
    )
  end

  def assign_todo
    if @todo.members.any?
      @member_before = @todo.members.first
      @todo.members.delete(@member_before)
    end

    TodoMember.create(
      todo_id: @todo.id,
      member_id: @member.id
    )
  end
end
