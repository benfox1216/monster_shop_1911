FactoryBot.define do
    factory :regular_user, class: User do
      name              { Faker::Games::Overwatch.hero }
      address           { Faker::Address.street_address }
      city              { Faker::Address.city }
      state             { Faker::Address.state_abbr }
      zip_code              { Faker::Address.zip }
      email_address            { Faker::Internet.email }
      password {password = Faker::Internet.password}
      role              { 0 }
    end
    factory :admin_user, class: User do
        name {Faker::FunnyName.name}
        address {Faker::Address.street_address}
        city {Faker::Address.city}
        state {Faker::Address.state}
        zip_code {Faker::Address.zip_code}
        email_address {Faker::Internet.email}
        password {password = Faker::Internet.password}
        role              { 1 }
      end
    factory :merchant_user, class: User do
        name {Faker::FunnyName.name}
        address {Faker::Address.street_address}
        city {Faker::Address.city}
        state {Faker::Address.state}
        zip_code {Faker::Address.zip_code}
        email_address {Faker::Internet.email}
        password {password = Faker::Internet.password}
        role              { 2 }
      end
  end