FactoryBot.define do
    factory :regular_user, class: User do
      name { Faker::TvShows::Simpsons.character  }
      address { Faker::Address.street_address }
      city { Faker::Address.city }
      state { Faker::Address.state_abbr }
      zip_code { Faker::Address.zip }
      email_address { Faker::Internet.email }
      password {password = Faker::Internet.password}
      created_at {Faker::Date.between(from: 6.days.ago, to: Date.today)}
      role { 0 }
    end
    factory :admin_user, class: User do
      name {Faker::TvShows::SouthPark.character }
      address {Faker::Address.street_address}
      city {Faker::Address.city}
      state {Faker::Address.state}
      zip_code {Faker::Address.zip_code}
      email_address {Faker::Internet.email}
      password {password = Faker::Internet.password}
      created_at {Faker::Date.between(from: 6.days.ago, to: Date.today)}
      role { 1 }
      end
    factory :merchant_user, class: User do
      name {Faker::TvShows::FamilyGuy.character}
      address {Faker::Address.street_address}
      city {Faker::Address.city}
      state {Faker::Address.state}
      zip_code {Faker::Address.zip_code}
      email_address {Faker::Internet.email}
      password {password = Faker::Internet.password}
      created_at {Faker::Date.between(from: 6.days.ago, to: Date.today)}
      role { 2 }
      association :merchant, factory: :random_merchant
      end
  end
