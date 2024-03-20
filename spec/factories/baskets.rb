FactoryBot.define do
  factory :basket do
    association :user, factory: :user
  end
end
