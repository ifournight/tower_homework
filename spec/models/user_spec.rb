require 'rails_helper'

RSpec.describe User, 'validations' do
  subject { User.new(name: 'ifournight') }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to (validate_length_of :name).is_at_least(4).is_at_most(15) }
end

RSpec.describe User, 'has many teams' do
  it { should have_many :team_memberships }
  it { should have_many :owned_teams }
  it { should have_many(:joined_teams).through(:team_memberships).source(:team) }
  it { should have_many(:todo_members) }
  it { should have_many(:working_todos).through(:todo_members).source(:todo) }
end
