require 'rails_helper'

RSpec.describe TeamMembership, 'validations' do
  it do
    is_expected.to validate_presence_of(:member_authority)
    is_expected.to validate_inclusion_of(:member_authority)
      .in_array(TeamMembership::MEMBERSHIP_AUTHORITY.values)
  end
end

RSpec.describe TeamMembership, '#relations' do
  it { should belong_to :member }
  it { should belong_to :team }
end
