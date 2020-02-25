require 'rails_helper'

describe "As an admin" do
  describe "When I visit admin's merchant index page" do
    before (:each) do
    @admin = create(:admin_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @merchant_1 = create(:random_merchant)
    @merchant_2 = create(:random_merchant)
    @item_1 = create(:random_item, merchant_id: @merchant_1.id)
    @item_2 = create(:random_item, merchant_id: @merchant_1.id)
    end 

    it "I am able to disable a merchant" do

      visit '/admin/merchants'

      expect(page).to have_link(@merchant_1.name)
      expect(page).to have_link(@merchant_1.name)

      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_button('Disable')
      end 
      within "#merchant-#{@merchant_1.id}" do
        click_button "Disable"
      end 


      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_content("#{@merchant_1.name} has been disabled")
     
      within "#merchant-#{@merchant_1.id}" do
        expect(page).to_not have_button('Disable')
        expect(page).to have_button('Enable')
      end 

      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_button('Disable')
      end       
    end
  end
end