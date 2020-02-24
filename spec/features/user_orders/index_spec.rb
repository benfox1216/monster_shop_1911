require 'rails_helper'

describe "As a registered user" do
  describe "When I visit my profile orders page" do
    before :each do
      @user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      @order_1 = @user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443")
      @order_2 = @user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443")

      visit "/profile/orders"
    end
    
    it "I see every order I have made, and the required info for each" do
      within "#order-#{@order_1.id}" do
        expect(page).to have_link(@order_1.id)
        expect(page).to have_content(@order_1.created_at)
        expect(page).to have_content(@order_1.updated_at)
        expect(page).to have_content(@order_1.status)
        expect(page).to have_content(@order_1.items.count)
        expect(page).to have_content("Total: $#{@order_1.grandtotal}")
      end
      
      within "#order-#{@order_2.id}" do
        expect(page).to have_link(@order_2.id)
        expect(page).to have_content(@order_2.created_at)
        expect(page).to have_content(@order_2.updated_at)
        expect(page).to have_content(@order_2.status)
        expect(page).to have_content(@order_2.items.count)
        expect(page).to have_content("Total: $#{@order_2.grandtotal}")
      end
    end
  end
end