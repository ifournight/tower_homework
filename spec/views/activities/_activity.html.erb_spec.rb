require 'rails_helper'

RSpec.describe 'activities/_activity.html.erb' do
  it 'display activity datetime, user avatar and content' do
    activity = create(:activity, created_at: 2.years.ago)

    render partial: 'activities/activity.html.erb', locals: { activity: activity }

    expect(rendered).to have_css "#activity_#{activity.id} [data-role='activity-created-at']",
                                 text: time_ago_in_words(activity.created_at)
    expect(rendered).to have_css "#activity_#{activity.id} [data-role='activity-user-avatar']"
    expect(rendered).to have_css "#activity_#{activity.id} [data-role='activity-content-wrapper']"
  end
end
