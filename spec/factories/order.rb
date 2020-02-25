FactoryBot.define do
  factory :random_order, class: Order do
    name {Faker::Color.color_name}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip {Faker::Address.zip_code}
    association :user, factory: :regular_user
  end
end
