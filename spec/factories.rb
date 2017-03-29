FactoryGirl.define do
  factory :activity do
    user_id 1
    action 'complete_todo'
    subject_type 'Todo'
    subject_id 1
  end
end
