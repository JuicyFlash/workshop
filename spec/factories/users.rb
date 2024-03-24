FactoryBot.define do
  factory :user do

    sequence(:email) { |n| "MyTestEmail_#{n}@gmail.com" }
    password {"1z2z3z4z5z6"}
    password_confirmation { '1z2z3z4z5z6' }
    name { "Ivan" }
    lastname { "Ivanov" }

    trait :invalid do
      title { nil }
    end
  end
end