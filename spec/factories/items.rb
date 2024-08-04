FactoryBot.define do
  factory :item do
    item_name                   { Faker::Commerce.product_name }
    explanation                 { Faker::Lorem.sentence }
    price                       { Faker::Number.between(from: 30, to: 9_999_999) }
    category_id                 { Faker::Number.between(from: 2, to: 11) }
    condition_id                { Faker::Number.between(from: 2, to: 7) }
    charge_load_id              { Faker::Number.between(from: 2, to: 3) }
    shipping_time_id            { Faker::Number.between(from: 2, to: 4) }
    area_id                     { Faker::Number.between(from: 2, to: 48) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/images.jpeg'), filename: 'images.jpeg')
    end
  end
end
