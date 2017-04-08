require 'rails_helper'

RSpec.describe Project, 'validations' do
  it do
    is_expected.to validate_presence_of :name
  end
end

RSpec.describe Project, 'relations' do
  it { should belong_to :team }
  it { should belong_to :creator }
  it { should have_many :todos }
  # it { should have_many :collaborators }
end
