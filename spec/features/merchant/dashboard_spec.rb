RSpec.describe 'as a merchant user' do

  before(:each) do
    @user = create(:merchant_user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end


  it 'should be able
  to show merchant info on dashboard page' do
    visit '/merchant'

    expect(page).to have_content(@user.merchant.name)
    expect(page).to have_content(@user.merchant.address)
    expect(page).to have_content(@user.merchant.city)
    expect(page).to have_content(@user.merchant.state)
    expect(page).to have_content(@user.merchant.zip)
  end

  it 'should be able to show pending orders' do
    item_1 = create(:random_item, merchant: @user.merchant)
    item_2 = create(:random_item, merchant: @user.merchant)

    item_order_1 = create(:random_item_order, item_id: item_1.id, price: 10.00, quantity: 2)
    item_order_2 = create(:random_item_order, item_id: item_2.id, order_id: item_order_1.order_id, price: 25.00, quantity: 1)
    item_order_3 = create(:random_item_order, item_id: item_2.id, price: 25.00, quantity: 2)

    visit '/merchant'

    within("#id-#{item_order_1.order_id}") do
      expect(page).to have_content("Order name: #{item_order_1.order.name}")
      expect(page).to have_link("#{item_order_1.order_id}")
      expect(page).to have_content("ID: #{item_order_1.order_id}")
      expect(page).to have_content("Order placed: #{item_order_1.created_at.to_formatted_s(:long)}")
      expect(page).to have_content("Number of items: #{item_order_1.quantity + item_order_2.quantity}")
      expect(page).to have_content("Total Price: $#{(item_order_1.quantity * item_order_1.price) + (item_order_2.quantity * item_order_2.price)}")

      click_on "#{item_order_1.order_id}"
      expect(current_path).to eq("/merchant/orders/#{item_order_1.order_id}")
    end
  end

  it 'should be able to view items index page from dashboard' do
    item_1 = create(:random_item, merchant: @user.merchant)
    item_2 = create(:random_item, merchant: @user.merchant)
    item_3 = create(:random_item, merchant: @user.merchant)

    visit '/merchant'

    click_link("My Items")
    expect(current_path).to eq("/merchant/items")
  end

  it 'should be able to view merchant dashboard as admin' do
    merchant = create(:random_merchant)
    admin = create(:admin_user)
    # require "pry"; binding.pry
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit '/merchants'
# require "pry"; binding.pry
    click_on merchant.name
    expect(current_path).to eq("/admin/merchants/#{merchant.id}")
  end

end
