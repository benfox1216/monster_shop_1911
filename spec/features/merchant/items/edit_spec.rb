RSpec.describe 'merchant item show page', type: :feature do

  before :each do
    @merchant_user = create(:merchant_user)

    @item_1 = create(:random_item, merchant: @merchant_user.merchant)
    @item_2 = create(:random_item, merchant: @merchant_user.merchant)
    @item_3 = create(:random_item, merchant: @merchant_user.merchant)
    @item_4 = create(:random_item, merchant: @merchant_user.merchant)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
  end

  it 'should update item' do
    visit '/merchant/items'

    within "#item-#{@item_1.id}" do
      click_button 'Edit'
    end

    expect(current_path).to eq("/merchant/items/#{@item_1.id}/edit")

    expect(find_field('Name').value).to eq @item_1.name
    expect(find_field('Description').value).to eq @item_1.description
    # save_and_open_page
    # require "pry"; binding.pry
    expect(find_field('Price').value).to eq @item_1.price.to_s
    expect(find_field('Image').value).to eq @item_1.image
    expect(find_field('Inventory').value).to eq @item_1.inventory.to_s

    name_2 = "Funky Flip Flops"

    fill_in :name, with: name_2

    click_button 'Update Item'

    expect(current_path).to eq("/merchant/items")

    within "#item-#{@item_1.id}" do
      expect(page).to have_content("Funky Flip Flops")
    end

    @item_1.write_attribute(:name, name_2)

    expect(page).to have_content("You have successfully updated #{@item_1.name}'s information.")
  end

  it 'should not update item if information missing' do
    visit "/merchant/items/#{@item_1.id}/edit"

    fill_in :name, with: ""

    click_button 'Update Item'

    expect(page).to have_content("You must complete all required fields before your item will be updated.")
  end
end
