require 'rails_helper'

RSpec.describe Todo, '#validations' do
  it { is_expected.to validate_presence_of :title }
end

RSpec.describe Todo, '#relations' do
  it { should belong_to(:creator) }
  it { should belong_to(:project) }
end
