require 'rails_helper'

describe "As a registered user" do
  describe "When I visit my profile orders page, I can click an order ID and see that order show page" do
    before :each do
      @user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12, purchased: 20)
      @high_roller_ball = bike_shop.items.create(name: "High Roller Ball", description: "Stays on surface", price: 100, image: "https://www.rei.com/media/3cda9ce5-420c-47d2-8095-bdc6ed84923c?size=784x588", inventory: 12, purchased: 19)
      
      @order = @user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443")
      ItemOrder.create!(item_id: @tire.id, order_id: @order.id, price: @tire.price, quantity: 2)
      ItemOrder.create!(item_id: @high_roller_ball.id, order_id: @order.id, price: @high_roller_ball.price, quantity: 3)
      
      visit "/profile/orders"
      
      within "#order-#{@order.id}" do
        click_link "#{@order.id}"
      end
      
      expect(current_path).to eq("/profile/orders/#{@order.id}")
    end
    
    xit "On my profile orders order show page, I see all the required info for that order" do
      expect(page).to have_content(@order.id)
      expect(page).to have_content(@order.created_at)
      expect(page).to have_content(@order.updated_at)
      expect(page).to have_content(@order.status)
      expect(page).to have_content(@order.items.count)
      expect(page).to have_content("Total: $#{@order.grandtotal}")
      
      within "#item-#{@tire.id}" do
        
      end
      
      within "#item-#{@high_roller_ball.id}" do
        
      end
      
      # - each item I ordered, including name, description, thumbnail, quantity, price and subtotal
    end
  end
end