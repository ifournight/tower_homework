require 'rails_helper'

RSpec.describe Project, 'validations' do
  it do
    is_expected.to validate_presence_of :name
  end
end

RSpec.describe Project, 'has many todos' do
  it { should have_many :todos }
  it { should belong_to :creator }
end
