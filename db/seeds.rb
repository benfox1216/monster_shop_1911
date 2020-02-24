# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Order.destroy_all
Merchant.destroy_all
Item.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12, purchased: 20)
high_roller_ball = bike_shop.items.create(name: "High Roller Ball", description: "Stays on surface", price: 100, image: "https://www.rei.com/media/3cda9ce5-420c-47d2-8095-bdc6ed84923c?size=784x588", inventory: 12, purchased: 19)
gnawt_a_rock = bike_shop.items.create(name: "Gnawt-A-Rock", description: "Holds treats", price: 100, image: "https://www.rei.com/media/252b0d74-f3cc-4b9d-8a7f-596440dfcc6c?size=784x588", inventory: 12, purchased: 18)
gnawt_a_stick = bike_shop.items.create(name: "Gnawt-A-Stick", description: "Stays upright", price: 100, image: "https://www.rei.com/media/40d8402b-8415-4cab-a9fd-eba14298527d?size=784x588", inventory: 12, purchased: 16)
hydro_plane = bike_shop.items.create(name: "Hydro Plane", description: "Maintains shape", price: 100, image: "https://www.rei.com/media/be369a77-4a9b-426a-b67a-12649856fb9c?size=784x588", inventory: 12, purchased: 14)

#dog_shop_items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32, purchased: 12)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21, purchased: 11)
soft_disc = dog_shop.items.create(name: "Soft Disc", description: "Soft and durable", price: 10, image: "https://www.rei.com/media/beb5df0b-0763-48ce-b487-7522a5b6a929", inventory: 32, purchased: 9)
huck_a_cone = dog_shop.items.create(name: "Huck-A_Cone", description: "Natural rubber", price: 10, image: "https://www.rei.com/media/71216e9a-fa1b-4dd0-a380-498ac5778894?size=784x588", inventory: 32, purchased: 7)
pacific_loop = dog_shop.items.create(name: "Pacific Loop", description: "Wide set handles", price: 10, image: "https://www.rei.com/media/fc850ada-324b-49c3-b15b-348ae246165f?size=784x588", inventory: 32, purchased: 6)
collapsible_thrower = dog_shop.items.create(name: "Collapsible Thrower", description: "Glows in the dark", price: 10, image: "https://www.rei.com/media/9ee5b433-dd30-4b29-923c-901e509e256b?size=784x588", inventory: 32, purchased: 4)

#users
user_1 = User.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip_code: "19443", email_address: "mrcool@gmail.com", password: "rh23489")

#orders
order_1 = user_1.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443")