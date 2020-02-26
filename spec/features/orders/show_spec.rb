require 'rails_helper'

describe "When I visit an order show page" do
  before(:each) do
    @user = create(:regular_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    
    @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12, purchased: 20)
    @high_roller_ball = @bike_shop.items.create(name: "High Roller Ball", description: "Stays on surface", price: 100, image: "https://www.rei.com/media/3cda9ce5-420c-47d2-8095-bdc6ed84923c?size=784x588", inventory: 12, purchased: 19)
    
    @order = @user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443")
    
    @item_order_1 = ItemOrder.create!(item_id: @tire.id, order_id: @order.id, price: @tire.price, quantity: 2)
    @item_order_2 = ItemOrder.create!(item_id: @high_roller_ball.id, order_id: @order.id, price: @high_roller_ball.price, quantity: 3)

    visit "/orders/#{@order.id}"
  end
  
  it "I see the order information" do
    expect(page).to have_content("#{@order.name}")
    expect(page).to have_content("#{@order.address}")
    expect(page).to have_content("#{@order.city}")
    expect(page).to have_content("#{@order.state}")
    expect(page).to have_content("#{@order.zip}")
    
    within "#item-#{@tire.id}" do
      expect(page).to have_link(@tire.name)
      expect(page).to have_link("#{@tire.merchant.name}")
      expect(page).to have_content("$#{@tire.price}")
      expect(page).to have_content("2")
      expect(page).to have_content("$200")
    end

    within "#item-#{@high_roller_ball.id}" do
      expect(page).to have_link(@high_roller_ball.name)
      expect(page).to have_link("#{@high_roller_ball.merchant.name}")
      expect(page).to have_content("$#{@high_roller_ball.price}")
      expect(page).to have_content("3")
      expect(page).to have_content("$300")
    end

    expect(page).to have_content("Total: $500")
    expect(page).to have_content(@order.created_at)
  end
end