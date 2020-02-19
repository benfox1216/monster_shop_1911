FactoryBot.define do
    factory :regular_user, class: User do
      name              { Faker::Games::Overwatch.hero }
      address           { Faker::Address.street_address }
      city              { GOTFaker::Geography.region }
      state             { Faker::Address.state_abbr }
      zip               { Faker::Address.zip }
      email             { Faker::Internet.email }
      password {password = Faker::Internet.password}
      role              { 0 }
    end
    # factory :admin_user, class: User do
    #     name {Faker::FunnyName.name}
    #     address {Faker::Address.street_address}
    #     city {Faker::Address.city}
    #     state {Faker::Address.state}
    #     zip_code {Faker::Address.zip_code}
    #     email {Faker::Internet.email}
    #     password {password = Faker::Internet.password}
    #     role              { 0 }
    #   end
  end