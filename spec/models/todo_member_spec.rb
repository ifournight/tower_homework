require 'rails_helper'

RSpec.describe TodoMember, 'relations' do
  it { should belong_to(:member) }
  it { should belong_to(:todo) }
end
