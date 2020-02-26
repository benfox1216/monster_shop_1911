require 'rails_helper'

describe "As a merchant", type: :feature do
  describe "when I visit an order show page from my dashboard" do
    before :each do
      @merchant_user_1 = create(:merchant_user)
      @merchant_user_2 = create(:merchant_user)
      @user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user_1)

      @item_1 = create(:random_item, merchant: @merchant_user_1.merchant)
      @item_2 = create(:random_item, merchant: @merchant_user_1.merchant)
      @item_3 = create(:random_item, merchant: @merchant_user_2.merchant)
      
      @order = create(:random_order, user: @user)
      
      @item_order_1 = ItemOrder.create!(item_id: @item_1.id, order_id: @order.id, price: @item_1.price, quantity: 2)
      @item_order_2 = ItemOrder.create!(item_id: @item_2.id, order_id: @order.id, price: @item_2.price, quantity: 3)
    end

    it "I see the user info that created the order, and only my items from the order" do
      visit "/merchant/orders/#{@order.id}"
      
      expect(page).to have_content(@order.id)
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zip_code)
      
      expect(page).to_not have_css("#item-#{@item_3.id}")
      
      within "#item-#{@item_1.id}" do
        expect(page).to have_link(@item_1.name)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@item_order_1.quantity)
        expect(page).to have_css("img[src*='#{@item_1.image}']")
      end
      
      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@item_order_2.quantity)
        expect(page).to have_css("img[src*='#{@item_2.image}']")
        click_link(@item_2.name)
      end
      
      expect(current_path).to eq("/items/#{@item_2.id}")
    end
    
    it "I can fulfill items I have in inventory" do
      visit "/merchant/orders/#{@order.id}"
      
      within "#item-#{@item_1.id}" do
        expect(page).to have_link("Fulfill Item")
      end
      
      within "#item-#{@item_2.id}" do
        expect(page).to have_link("Fulfill Item")
      end
      
      @item_1.update(inventory: 1)
      visit "/merchant/orders/#{@order.id}"
      
      within "#item-#{@item_1.id}" do
        expect(page).to_not have_link("Fulfill Item")
      end
      
      @item_1.update(inventory: 10)
      visit "/merchant/orders/#{@order.id}"
      
      within "#item-#{@item_1.id}" do
        expect(page).to have_link("Fulfill Item")
      end
      
      @item_order_1.update(status: "fulfilled")
      visit "/merchant/orders/#{@order.id}"
      
      within "#item-#{@item_1.id}" do
        expect(page).to_not have_link("Fulfill Item")
        expect(page).to have_content("This item has been fulfilled")
      end
      
      @item_order_1.update(status: "unfulfilled")
      visit "/merchant/orders/#{@order.id}"
      
      within "#item-#{@item_1.id}" do
        click_link "Fulfill Item"
      end
      
      @item_1.reload
      
      expect(current_path).to eq("/merchant/orders/#{@order.id}")
      
      expect(page).to have_content("You have fulfilled the order for #{@item_1.name}")
      expect(@item_1.inventory).to eq(8)
    end
    
    it "I cannot fulfill an item if I don't have the inventory" do
      @item_1.update(inventory: 2)
      visit "/merchant/orders/#{@order.id}"
      
      within "#item-#{@item_1.id}" do
        expect(page).to have_link("Fulfill Item")
      end
      
      @item_1.update(inventory: 1)
      visit "/merchant/orders/#{@order.id}"
      
      within "#item-#{@item_1.id}" do
        expect(page).to_not have_link("Fulfill Item")
        expect(page).to have_content("You cannot fulfill this item due to lack of inventory")
      end
    end
  end
end