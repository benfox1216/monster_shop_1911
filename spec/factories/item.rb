FactoryBot.define do
  factory :random_item, class: Item do
    name {Faker::Commerce.product_name}
    description {Faker::Lorem.sentence}
    price {Faker::Number.between(from: 1, to: 100)}
    sequence(:image) {|n| "http://lorempixel.com/400/300/abstract/#{n}"}
    inventory {Faker::Number.between(from: 1, to: 500)}
  end
end
