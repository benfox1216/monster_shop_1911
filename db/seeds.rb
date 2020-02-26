ItemOrder.destroy_all
Order.destroy_all
Item.destroy_all
Review.destroy_all
User.destroy_all
Merchant.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
leggos  = Merchant.create(name: "leggos Not Eggos", address: '654 Leggo St.', city: 'Denver', state: 'CO', zip: 80202)

#bike_shop items
tire = bike_shop.items.create!(name: "Tire", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12, purchased: 20)
high_roller_ball = bike_shop.items.create!(name: "High Roller Ball", description: "Stays on surface", price: 100, image: "https://www.rei.com/media/3cda9ce5-420c-47d2-8095-bdc6ed84923c?size=784x588", inventory: 12, purchased: 19)
gnawt_a_rock = bike_shop.items.create!(name: "Gnawt-A-Rock", description: "Holds treats", price: 100, image: "https://www.rei.com/media/252b0d74-f3cc-4b9d-8a7f-596440dfcc6c?size=784x588", inventory: 12, purchased: 18)
gnawt_a_stick = bike_shop.items.create!(name: "Gnawt-A-Stick", description: "Stays upright", price: 100, image: "https://www.rei.com/media/40d8402b-8415-4cab-a9fd-eba14298527d?size=784x588", inventory: 12, purchased: 16)
hydro_plane = bike_shop.items.create!(name: "Hydro Plane", description: "Maintains shape", price: 100, image: "https://www.rei.com/media/be369a77-4a9b-426a-b67a-12649856fb9c?size=784x588", inventory: 12, purchased: 14)

#dog_shop_items
pull_toy = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32, purchased: 12)
dog_bone = dog_shop.items.create!(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21, purchased: 11)
soft_disc = dog_shop.items.create!(name: "Soft Disc", description: "Soft and durable", price: 10, image: "https://www.rei.com/media/beb5df0b-0763-48ce-b487-7522a5b6a929", inventory: 32, purchased: 9)
huck_a_cone = dog_shop.items.create!(name: "Huck-A_Cone", description: "Natural rubber", price: 10, image: "https://www.rei.com/media/71216e9a-fa1b-4dd0-a380-498ac5778894?size=784x588", inventory: 32, purchased: 7)
pacific_loop = dog_shop.items.create!(name: "Pacific Loop", description: "Wide set handles", price: 10, image: "https://www.rei.com/media/fc850ada-324b-49c3-b15b-348ae246165f?size=784x588", inventory: 32, purchased: 6)
collapsible_thrower = dog_shop.items.create!(name: "Collapsible Thrower", description: "Glows in the dark", price: 10, image: "https://www.rei.com/media/9ee5b433-dd30-4b29-923c-901e509e256b?size=784x588", inventory: 32, purchased: 4)

#leggo shop
batmobile = leggos.items.create(name: "1989 Batmobile", description: "Original Battmovile", price: 30, image: 'https://www.bigw.com.au/medias/sys_master/images/images/h1f/h87/13909151023134.jpg', inventory: 1, purchased: 4)
olaf = leggos.items.create(name: "Olaf", description: "The snowman that can talk", price: 15, image: 'https://www.thebrickfan.com/wp-content/uploads/2019/10/Olafs-Traveling-Sleigh-40361.jpg', inventory: 20, purchased: 6)
baby_yoda = leggos.items.create(name: "Baby Yoda", description: "Baby Yoda", price: 1000000000, image: 'https://www.htxt.co.za/wp-content/uploads/2020/02/75317-The-Mandalorian-The-Child-H-LEGO.png', inventory: 1, purchased: 0)

#users
user_1 = User.create!(name: "Benji Wolf", address: "123 Heart Pl", city: "Reno", state: "NV", zip_code: "19443", email_address: "mrcool@gmail.com", password: "rh23489", role: 0)
user_2 = User.create!(name: "Mike Wazowski ", address: "99887 Erie Ct", city: "San Francisco", state: "CA", zip_code: "23534", email_address: "pambelam@gmail.com", password: "r3afew4q3", role: 0)
merchant = User.create!(name: "Danny Moron", address: "456 Uncool St", city: "Colorado Springs", state: "CO", zip_code: "54239", email_address: "uncannydanny@4realz.com", password: "t4389", role: 2, merchant: bike_shop)
admin = User.create!(name: "Zeke Fleek", address: "23832 Harbor Ave", city: "Boulder", state: "CO", zip_code: "54239", email_address: "zekeefleeky@altavista.com", password: "feqnu", role: 1)

#orders
order_2 = user_2.orders.create!(name: "Mike Wazowski", address: "99887 Erie Ct", city: "San Francisco", state: "CA", zip: "23534")
order_1 = user_1.orders.create!(name: "Benji Wolf", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443")

#reviews
review_1 = collapsible_thrower.reviews.create(title: "why is this collapsible", content: "Where is the non-collapsible", rating: 1)
review_2 = baby_yoda.reviews.create(title: "Wish I could afford it!", content: "too expesive yet worth it", rating: 5)
review_3 = tire.reviews.create(title: "Good ol' trusty tire", content: "truthworth", rating: 5)

#item_orders
ItemOrder.create!(item_id: dog_bone.id, order_id: order_1.id, quantity: 30, price: dog_bone.price)
ItemOrder.create!(item_id: tire.id, order_id: order_1.id, quantity: 5, price: tire.price)
ItemOrder.create!(item_id: hydro_plane.id, order_id: order_2.id, quantity: 10, price: hydro_plane.price)
ItemOrder.create!(item_id: collapsible_thrower.id, order_id: order_2.id, quantity: 5, price: collapsible_thrower.price)
