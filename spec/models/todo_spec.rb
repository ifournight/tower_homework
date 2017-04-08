require 'rails_helper'

RSpec.describe Todo, 'validations' do
  it { is_expected.to validate_presence_of :title }
end

RSpec.describe Todo, 'relations' do
  it { should belong_to(:creator) }
  it { should belong_to(:project) }
  it { should have_many(:todo_members) }
  it { should have_many(:members).through(:todo_members) }
end

RSpec.describe Todo, '#over_due?' do

  before :each do
    user = create(:user)
    team = create(:team, owner: user)
    project = create(:project, team: team, creator: user)

    @todo = create(:todo, project: project, creator: user)
  end

  it 'return true when over_due' do
    @todo.deadline = 1.day.ago
    @todo.save!

    expect(@todo.over_due?).to eq true
  end

  it 'return false when not over_due' do
    @todo.deadline = Time.zone.now + 1.day
    @todo.save!

    expect(@todo.over_due?).to eq false
  end

end

RSpec.describe Todo, 'assigned_member' do
  before :each do
    @user = create(:user)
    team = create(:team, owner: @user)
    project = create(:project, team: team, creator: @user)

    @todo = create(:todo, project: project, creator: @user)
  end

  it 'return nil when todo has no assigned' do
    expect(@todo.assigned_member).to eq nil
  end

  it 'return first of members if todo has any assigned members' do
    TodoMember.create(todo_id: @todo.id, member_id: @user.id)

    expect(@todo.assigned_member.id).to eq @user.id
  end
end
