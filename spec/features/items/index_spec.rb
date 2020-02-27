require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12, purchased: 20)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32, purchased: 19)
      @high_roller_ball = @meg.items.create(name: "High Roller Ball", description: "Stays on surface", price: 100, image: "https://www.rei.com/media/3cda9ce5-420c-47d2-8095-bdc6ed84923c?size=784x588", inventory: 12, purchased: 18)
      @soft_disc = @brian.items.create(name: "Soft Disc", description: "Soft and durable", price: 10, image: "https://www.rei.com/media/beb5df0b-0763-48ce-b487-7522a5b6a929", inventory: 32, purchased: 16)
      @gnawt_a_rock = @meg.items.create(name: "Gnawt-A-Rock", description: "Holds treats", price: 100, image: "https://www.rei.com/media/252b0d74-f3cc-4b9d-8a7f-596440dfcc6c?size=784x588", inventory: 12, purchased: 14)
      @huck_a_cone = @brian.items.create(name: "Huck-A_Cone", description: "Natural rubber", price: 10, image: "https://www.rei.com/media/71216e9a-fa1b-4dd0-a380-498ac5778894?size=784x588", inventory: 32, purchased: 13)
      @gnawt_a_stick = @meg.items.create(name: "Gnawt-A-Stick", description: "Stays upright", price: 100, image: "https://www.rei.com/media/40d8402b-8415-4cab-a9fd-eba14298527d?size=784x588", inventory: 12, purchased: 11)
      @pacific_loop = @brian.items.create(name: "Pacific Loop", description: "Wide set handles", price: 10, image: "https://www.rei.com/media/fc850ada-324b-49c3-b15b-348ae246165f?size=784x588", inventory: 32, purchased: 9)
      @hydro_plane = @meg.items.create(name: "Hydro Plane", description: "Maintains shape", price: 100, image: "https://www.rei.com/media/be369a77-4a9b-426a-b67a-12649856fb9c?size=784x588", inventory: 12, purchased: 7)
      @collapsible_thrower = @brian.items.create(name: "Collapsible Thrower", description: "Glows in the dark", price: 10, image: "https://www.rei.com/media/9ee5b433-dd30-4b29-923c-901e509e256b?size=784x588", inventory: 32, purchased: 6)

      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21, purchased: 4)
    end

    it "all items, merchant names, and images are links" do
      visit '/items'

      within ".grid-container" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_link(@tire.merchant.name)
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_link(@pull_toy.merchant.name)
        expect(page).to_not have_link(@dog_bone.name)

        click_link("img-#{@tire.id}")
      end
      expect(current_path).to eq("/items/#{@tire.id}")
    end

    it "I can see a list of all of the items, except disabled items" do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

      expect(page).to_not have_field("#item-#{@dog_bone.id}")
    end

    it "There are statistics at the top of the page" do
      visit '/items'

      within "#most_popular" do
        expect(page).to have_content("Most Popular Items:")
        expect(page).to have_link(@tire.name)
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_link(@high_roller_ball.name)
        expect(page).to have_link(@soft_disc.name)
        expect(page).to have_link(@gnawt_a_rock.name)
        expect(page).to have_content(@tire.purchased)
        expect(page).to have_content(@pull_toy.purchased)
        expect(page).to have_content(@high_roller_ball.purchased)
        expect(page).to have_content(@soft_disc.purchased)
        expect(page).to have_content(@gnawt_a_rock.purchased)
      end

      within "#least_popular" do
        expect(page).to have_content("Least Popular Items:")
        expect(page).to have_link(@huck_a_cone.name)
        expect(page).to have_link(@gnawt_a_stick.name)
        expect(page).to have_link(@pacific_loop.name)
        expect(page).to have_link(@hydro_plane.name)
        expect(page).to have_link(@collapsible_thrower.name)
        expect(page).to have_content(@huck_a_cone.purchased)
        expect(page).to have_content(@gnawt_a_stick.purchased)
        expect(page).to have_content(@pacific_loop.purchased)
        expect(page).to have_content(@hydro_plane.purchased)
        expect(page).to have_content(@collapsible_thrower.purchased)
      end
    end
  end
end
