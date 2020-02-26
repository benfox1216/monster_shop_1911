RSpec.describe 'merchant item show page', type: :feature do

  before :each do
    @merchant_user = create(:merchant_user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
  end

  it 'should' do
    visit '/merchant/items'

    click_link 'Add New Item'

    name = "A Big-a Pizza Pie"
    description = 'Very delicioso'
    image = "https://cdn.popmenu.com/image/upload/c_limit,f_auto,h_1440,q_auto,w_1440/twave3pm189b1ezmkrkq.jpg"
    price = 15.00
    inventory = 50

    click_button("Create Item")
    expect(page).to have_content("Name can't be blank, Description can't be blank, Price can't be blank, Price is not a number, and Inventory can't be blank")

    visit '/merchant/items/new'

    fill_in :name, with: name
    fill_in :description, with: description
    fill_in :image, with: image
    fill_in :price, with: price
    fill_in :inventory, with: inventory
    # require "pry"; binding.pry
    click_button("Create Item")
    save_and_open_page

    new_item = Item.last

    expect(page).to have_content("Your new item has been saved.")
    expect(page).to have_content(name)
    expect(page).to have_content(description)
    expect(page).to have_content(new_item.image)
    expect(new_item.image).to eq(image)
    expect(page).to have_content(inventory)
  end
end
