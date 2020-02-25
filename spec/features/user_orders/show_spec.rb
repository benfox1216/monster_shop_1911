require 'rails_helper'

describe "As a registered user" do
  describe "When I visit my profile orders page, I can click an order ID and see that order show page" do
    before :each do
      @user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12, purchased: 20)
      @high_roller_ball = @bike_shop.items.create(name: "High Roller Ball", description: "Stays on surface", price: 100, image: "https://www.rei.com/media/3cda9ce5-420c-47d2-8095-bdc6ed84923c?size=784x588", inventory: 12, purchased: 19)
      
      @order = @user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443")
      @item_order_1 = ItemOrder.create!(item_id: @tire.id, order_id: @order.id, price: @tire.price, quantity: 2)
      @item_order_2 = ItemOrder.create!(item_id: @high_roller_ball.id, order_id: @order.id, price: @high_roller_ball.price, quantity: 3)
      
      visit "/profile/orders"
      
      within "#order-#{@order.id}" do
        click_link "#{@order.id}"
      end
      
      expect(current_path).to eq("/profile/orders/#{@order.id}")
    end
    
    it "On my profile orders order show page, I see all the required info for that order" do
      expect(page).to have_content(@order.id)
      expect(page).to have_content(@order.created_at)
      expect(page).to have_content(@order.updated_at)
      expect(page).to have_content(@order.status)
      expect(page).to have_content(@order.items.count)
      expect(page).to have_content("Total: $#{@order.grandtotal}")
      
      within "#item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content(@item_order_1.quantity)
        expect(page).to have_content(@tire.price)
        expect(page).to have_content(@item_order_1.subtotal)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end
      
      within "#item-#{@high_roller_ball.id}" do
        expect(page).to have_content(@high_roller_ball.name)
        expect(page).to have_content(@high_roller_ball.description)
        expect(page).to have_content(@item_order_2.quantity)
        expect(page).to have_content(@high_roller_ball.price)
        expect(page).to have_content(@item_order_2.subtotal)
        expect(page).to have_css("img[src*='#{@high_roller_ball.image}']")
      end
    end
    
    it "I'm able to cancel an order, where the required outcomes occur" do
      @item_order_1[:status] = "fulfilled"
      @item_order_2[:status] = "fulfilled"
      
      click_link "Cancel Order"
      @tire.reload
      @high_roller_ball.reload
      @item_order_1.reload
      @item_order_2.reload
      @order.reload
      
      expect(@item_order_1[:status]).to eq("unfulfilled")
      expect(@item_order_2[:status]).to eq("unfulfilled")
      expect(@tire[:inventory]).to eq(14)
      expect(@high_roller_ball[:inventory]).to eq(15)
      expect(@order[:status]).to eq("cancelled")
      
      expect(current_path).to eq('/profile')
      expect(page).to have_content("Your order has been cancelled")
      
      visit '/profile/orders'
      
      within "#order-#{@order.id}" do
        expect(page).to have_content("cancelled")
      end
    end
    
    it "When all items are fulfilled, the order status becomes packaged" do
      expect(@order[:status]).to eq("pending")
      
      merchant_user = create(:merchant_user)
      merchant_user[:merchant_id] = @bike_shop.id
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)
      visit "/merchant/orders/#{@order.id}"
      
      within "#item-#{@tire.id}" do
        click_link "Fulfill Item"
      end
      
      expect(@order.status).to eq("pending")
      
      within "#item-#{@high_roller_ball.id}" do
        click_link "Fulfill Item"
      end
      
      @order.reload
      
      expect(@order.status).to eq("packaged")
    end
  end
end