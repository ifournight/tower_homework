require 'rails_helper'

RSpec.describe Team, 'validations' do
  it { is_expected.to validate_presence_of :name }
end

RSpec.describe Team, 'has many members' do
  it { should have_many :team_memberships }
  it { should have_many(:members).through(:team_memberships) }
  it { should belong_to(:owner).class_name('User') }
  it { should have_many(:projects) }
end
