require 'rails_helper'

RSpec.describe Activity, 'relations' do
  it { should belong_to :user }
  it { should belong_to :subject }
  it { should belong_to :project }
end
