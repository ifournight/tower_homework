require 'rails_helper'

RSpec.feature 'User create and submit a new todo' do
  scenario 'he/she see the created todo' do
    user = create(:user)
    sign_in(user)
    first_todo = create(:todo, title: 'First todo')

    visit root_url

    expect(page).to have_css "#todo_#{first_todo.id}"
  end
end
