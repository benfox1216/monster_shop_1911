RSpec.describe 'merchant item show page', type: :feature do

  before :each do
    @merchant = create(:merchant_user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

    @item_1 = create(:random_item, merchant: @merchant.merchant)
    @item_2 = create(:random_item, merchant: @merchant.merchant)
    @item_3 = create(:random_item, merchant: @merchant.merchant)
    @item_4 = create(:random_item, merchant: @merchant.merchant)
  end

  it 'should' do
    visit '/merchant/items'

    within "#item-#{@item_1.id}" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.image)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.active?)
      expect(page).to have_content(@item_1.inventory)
      click_button("Deactivate")
    end

    visit '/merchant/items'

    within "#item-#{@item_3.id}" do
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_3.image)
      expect(page).to have_content(@item_3.description)
      expect(page).to have_content(@item_3.active?)
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
