require 'rails_helper'

RSpec.describe User, 'validations' do
  subject { User.new(name: 'ifournight') }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to (validate_length_of :name).is_at_least(4).is_at_most(15) }
end
