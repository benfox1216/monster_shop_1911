RSpec.describe 'merchant item show page', type: :feature do

  before :each do
    @merchant_user = create(:merchant_user)

    @item_1 = create(:random_item, merchant: @merchant_user.merchant)
    @item_2 = create(:random_item, merchant: @merchant_user.merchant)
    @item_3 = create(:random_item, merchant: @merchant_user.merchant)
    @item_4 = create(:random_item, merchant: @merchant_user.merchant)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
  end

  it 'should' do
    visit '/merchant/items'

    within "#item-#{@item_1.id}" do
      click_button 'Edit'
    end

    expect(current_path).to eq("/merchant/items/#{@item_1.id}/edit")


    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_1.description)
    expect(page).to have_content(@item_1.price)
    expect(page).to have_content(@item_1.inventory)

    fill_in :name, with: "Funky Flip Flops"

    click_link 'Update Item'

    expect(current_path).to eq("/merchant/items")

    within "#item-#{@item_1.id}" do
      expect(page).to have_content("Funky Flip Flops")
    end

    expect(page).to have_content("You have successfully updated #{@item_1.name}'s information.")
  end
end
