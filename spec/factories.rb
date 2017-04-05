FactoryGirl.define do
  factory :access do
    user
    type Access::ACCESS_TYPE[:PROJECT_COLLABORATOR]
    association :subject, factory: :project
  end

  factory :project do
    creator
    team
    sequence(:name) { |n| "Project #{n}" }
  end

  factory :team do
    owner
    sequence(:name) { |n| "Team #{n}" }
  end

  factory :todo, aliases: [:subject] do
    project
    creator
    sequence(:title) { |n| "Todo #{n}" }

    trait :invalid do
      title nil
    end
  end

  factory :user, aliases: [:creator, :owner] do
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
