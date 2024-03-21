FactoryBot.define do
  factory :basket_product do
    association :product, factory: :product
    association :basket, factory: :basket
  end
end