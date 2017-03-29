FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
  end

  factory :activity do
    user
    action Activity::ACTION_TYPES[:COMPLETE_TODO]
    subject_type 'Todo'
    subject_id 1
  end
end
