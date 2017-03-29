require 'rails_helper'

RSpec.describe 'activities/_activity.html.erb' do
  it 'display activity datetime' do
    activity = create(:activity, created_at: 2.years.ago)

    render partial: 'activities/activity.html.erb', locals: { activity: activity }

    expect(rendered).to have_css "#activity_#{activity.id} [data-role='datetime']",
                                 text: time_ago_in_words(activity.created_at)
  end
end
