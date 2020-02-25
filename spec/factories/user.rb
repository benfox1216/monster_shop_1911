FactoryBot.define do
    factory :regular_user, class: User do
      name { Faker::Sports::Football.name }
      address { Faker::Address.street_address }
      city { Faker::Address.city }
      state { Faker::Address.state_abbr }
      zip_code { Faker::Address.zip }
      email_address { Faker::Internet.email }
      password {password = Faker::Internet.password}
      role { 0 }
    end
    factory :admin_user, class: User do
      name {Faker::Kpop.solo}
      address {Faker::Address.street_address}
      city {Faker::Address.city}
      state {Faker::Address.state}
      zip_code {Faker::Address.zip_code}
      email_address {Faker::Internet.email}
      password {password = Faker::Internet.password}
      role { 1 }
      end
    factory :merchant_user, class: User do
      name {Faker::Vehicle.make_and_model}
      address {Faker::Address.street_address}
      city {Faker::Address.city}
      state {Faker::Address.state}
      zip_code {Faker::Address.zip_code}
      email_address {Faker::Internet.email}
      password {password = Faker::Internet.password}
      role { 2 }
      association :merchant, factory: :random_merchant
      end
  end
