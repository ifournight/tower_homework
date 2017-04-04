FactoryGirl.define do
  factory :todo, aliases: [:subject] do
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
    subject
    action Activity::ACTION_TYPES[:COMPLETE_TODO]

    trait :create_todo do
      user
      subject
      action Activity::ACTION_TYPES[:CREATE_TODO]
    end
  end
end
