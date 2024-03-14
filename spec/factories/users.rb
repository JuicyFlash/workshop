FactoryBot.define do
  factory :user do

    sequence(:email) { |n| "MyTestEmail_#{n}@gmail.com" }
    name { "Ivan" }
    lastname { "Ivanov" }

    trait :invalid do
      title { nil }
    end
  end
end