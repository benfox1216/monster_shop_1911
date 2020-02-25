require 'rails_helper'

describe "As an admin user" do
  describe "When I visit my dashboard" do
    before :each do
      @admin = create(:admin_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      
      @merchant = create(:random_merchant)
      @item_1 = create(:random_item, merchant_id: @merchant.id)
      @item_2 = create(:random_item, merchant_id: @merchant.id)

      @user = create(:regular_user)
      @order_1 = @user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443", status: "pending")
      @order_2 = @user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443", status: "cancelled")
      
      @item_order_1 = ItemOrder.create!(item_id: @item_1.id, order_id: @order_1.id, price: @item_1.price, quantity: 2)
      @item_order_2 = ItemOrder.create!(item_id: @item_2.id, order_id: @order_2.id, price: @item_2.price, quantity: 3)

      visit '/admin'
    end
    
    it "I can see all the orders in the system, sorted by status" do
      expect(page).to have_content("Packaged", count: 1)
      expect(page).to have_content("Pending", count: 1)
      expect(page).to have_content("Shipped", count: 1)
      expect(page).to have_content("Cancelled", count: 1)
      
      within "#pending-#{@order_1.id}" do
        expect(page).to have_link(@order_1.user.name)
        expect(page).to have_content("Order ID: #{@order_1.id}")
        expect(page).to have_content("Created: #{@order_1.created_at}")
      end

      within "#cancelled-#{@order_2.id}" do
        expect(page).to have_content("Order ID: #{@order_2.id}")
        expect(page).to have_content("Created: #{@order_2.created_at}")
        click_link "#{@order_2.user.name}"
      end
    end
    
    it "I can ship any order that have the status of packages" do
      order_3 = @user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443", status: "packaged")
      item_order_3 = ItemOrder.create!(item_id: @item_2.id, order_id: order_3.id, price: @item_2.price, quantity: 3)
      
      visit '/admin'
      
      within "#packaged-#{order_3.id}" do
        click_link("Ship")
      end
      
      expect(current_path).to eq("/admin")
      
      within "#packaged-#{order_3.id}" do
        expect(page).to_not have_link(order_3.user.name)
      end
      
      within "#shipped-#{order_3.id}" do
        expect(page).to have_link(order_3.user.name)
      end
      
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      visit "/profile/orders/#{order_3.id}"
      expect(page).to_not have_content("Cancel Order")
    end
  end
end