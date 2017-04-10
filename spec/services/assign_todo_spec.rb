require 'rails_helper'

RSpec.describe AssignTodo, '#do' do
  before :each do
    @authorizer = create(:user, name: 'ifournight')
    @member = create(:user, name: 'momo')
    @project = double(id: 1, class: double(name: 'Project'))
    @todo = double(id: 1, project_id: 1, title: 'First todo', creator_id: 1, project: @project)

    @assign_todo = AssignTodo.new(
      authorizer_id: @authorizer.id,
      member_id: @member.id,
      todo_id: @todo.id
    )
  end

  context 'authorizer with no access' do
    it "can't assign todo" do
      allow(@assign_todo).to receive(:valid_todo_id).and_return(true)
      allow(@assign_todo).to receive(:check_already_member).and_return(true)
      allow(Access).to receive(:has_access?).and_return(false)
      allow(Todo).to receive(:find).and_return(@todo)

      result = @assign_todo.do

      expect(result).to eq nil
      expect(@assign_todo.errors[:authorizer_id].join).to match "doesn't have access"
    end
  end

  context 'assign again to the same member' do
    it 'will fail and return nil' do
      allow(@assign_todo).to receive(:valid_todo_id).and_return(true)
      allow(@assign_todo).to receive(:check_authorizer_access).and_return(true)
      allow(@assign_todo).to receive(:check_already_member) do
        @assign_todo.errors.add(:member_id, 'already assigned')
      end

      allow(Todo).to receive(:find).and_return(@todo)

      result = @assign_todo.do

      expect(result).to eq nil
      expect(@assign_todo.errors[:member_id].join).to match 'already assigned'
    end
  end

  context 'valid params' do
    it 'assign todo and create related activity' do
      team = CreateTeam.new(creator_id: @authorizer.id, team_name: 'Citizen 4').do
      project = CreateProject.new(creator_id: @authorizer.id, team_id: team.id, project_name: 'V coming').do
      todo = CreateTodo.new(project_id: project.id, creator_id: @authorizer.id, title: 'First todo').create
      assign_todo = AssignTodo.new(member_id: @member.id, authorizer_id: @authorizer.id, todo_id: todo.id)
      # allow(@assign_todo).to receive(:valid_todo_id).and_return(true)
      # allow(@assign_todo).to receive(:check_authorizer_access).and_return(true)
      # allow(@assign_todo).to receive(:check_already_member).and_return(true)
      # allow(Todo).to receive(:find).and_return(@todo)

      result = assign_todo.do
      activity = Activity.last

      expect(result).to eq todo
      expect(todo.members.count).to eq 1
      expect(todo.members.include?(@member)).to eq true
      expect(activity.action).to eq Activity::ACTION_TYPES[:ASSIGN_TODO]
      expect(activity.subject_id).to eq todo.id
    end
  end
end
