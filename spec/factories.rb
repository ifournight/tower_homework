FactoryGirl.define do
  factory :todo do
    creator
    sequence(:title) { |n| "Todo #{n}" }

    trait :invalid do
      title nil
    end
  end

  factory :user, aliases: [:creator] do
    sequence(:name) { |n| "User #{n}" }
  end

  factory :activity do
    user
    action Activity::ACTION_TYPES[:COMPLETE_TODO]
    subject_type 'Todo'
    subject_id 1
  end
end
