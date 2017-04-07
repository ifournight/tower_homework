require 'rails_helper'

RSpec.describe Activity, 'attributes' do
  it 'serialize extra into Hash' do
    extra = { key: 'value' }
    activity = create(:activity, extra: extra)

    expect(activity.extra[:key]).to eq 'value'
  end
end
