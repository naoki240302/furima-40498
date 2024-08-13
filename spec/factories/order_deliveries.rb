FactoryBot.define do
  factory :order_delivery do
    post_number do
      Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4)
    end
    area_id                     { Faker::Number.between(from: 2, to: 48) }
    address                     { Faker::Address.city }
    street                      { Faker::Address.street_address }
    building                    { Faker::Company.name }
    phone_number                { Faker::Number.leading_zero_number(digits: 11) }
  end
end
