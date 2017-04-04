require 'rails_helper'

RSpec.describe 'activities/_activity_create_todo.html.erb' do
  it 'display activity datetime, user avatar and content' do
    activity = create(:activity, :create_todo)

    render partial: 'activities/activity_create_todo.html.erb', locals: { activity: activity }

    expect(rendered).to have_css "[data-role='activity-username']",
                                 text: activity.user.name
    expect(rendered).to have_css "[data-role='activity-description']"
    expect(rendered).to have_css "[data-role='activity-subject']",
                                 text: activity.subject.title
  end
end
