FactoryBot.define do
  factory :order_detail do
    association :order, factory: :order
    first_name { 'MyFirstName' }
    last_name { 'MyLastName' }
    city { 'MyCity' }
    street { 'MyStreet' }
    house { 'MyHouse' }
    phone { 'MyPhone' }
  end
end
