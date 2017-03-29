FactoryGirl.define do
  factory :activity do
    user_id 1
    action Activity::ACTION_TYPES[:COMPLETE_TODO]
    subject_type 'Todo'
    subject_id 1
  end
end
