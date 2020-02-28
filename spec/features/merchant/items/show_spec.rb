RSpec.describe 'merchant item show page', type: :feature do

  before :each do
    @merchant_user = create(:merchant_user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

    @item_1 = create(:random_item, merchant: @merchant_user.merchant)
    @item_2 = create(:random_item, merchant: @merchant_user.merchant)
    @item_3 = create(:random_item, merchant: @merchant_user.merchant)
    @item_4 = create(:random_item, merchant: @merchant_user.merchant)
  end

  it 'should be able to delete items that have never been ordered' do
    bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    user = create(:regular_user)

    order = user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443")

    item_order_1 = ItemOrder.create!(item_id: @item_1.id, order_id: order.id, price: @item_1.price, quantity: 2)

    item_order_2 = ItemOrder.create!(item_id: @item_2.id, order_id: order.id, price: @item_2.price, quantity: 3)

    visit '/merchant/items'

    within "#item-#{@item_1.id}" do
      expect(page).to_not have_button("Delete")
    end

    within "#item-#{@item_2.id}" do
      expect(page).to_not have_button("Delete")
    end

    within "#item-#{@item_3.id}" do
      expect(page).to have_button("Delete")
    end

    within "#item-#{@item_4.id}" do
      expect(page).to have_button("Delete")
    end
  end

  it 'should' do
    visit '/merchant/items'

    within "#item-#{@item_1.id}" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_css("img[src*='#{@item_1.image}']")
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content("Active")
      expect(page).to have_content(@item_1.inventory)
      click_button("Deactivate")
    end

    visit '/merchant/items'

    within "#item-#{@item_3.id}" do
      expect(page).to have_content(@item_3.name)
      expect(page).to have_css("img[src*='#{@item_3.image}']")
      expect(page).to have_content(@item_3.description)
      expect(page).to have_content("Active")
      expect(page).to have_content(@item_3.inventory)
      click_button("Deactivate")
    end

    visit '/merchant/items'

    within "#item-#{@item_1.id}" do
      expect(page).to have_button("Activate")
    end

    within "#item-#{@item_2.id}" do
      expect(page).to have_button("Deactivate")
    end

    within "#item-#{@item_3.id}" do
      expect(page).to have_button("Activate")
    end

    within "#item-#{@item_4.id}" do
      expect(page).to have_button("Deactivate")
    end
  end

end
