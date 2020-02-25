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
    @item_3 = create(:random_item, merchant_id: @merchant_2.id)
    @item_4 = create(:random_item, merchant_id: @merchant_2.id)
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

      @merchant_1.reload
      
      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_content("#{@merchant_1.name} has been disabled")
      expect(@merchant_1.status).to eq('disabled') 
      
      within "#merchant-#{@merchant_1.id}" do
        expect(page).to_not have_button('Disable')
        expect(page).to have_button('Enable')
      end 
      
      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_button('Disable')
      end       
    end
    
    it "clicking on 'disable' button decactivates that merchant's items" do 
      visit '/admin/merchants'
      
      within "#merchant-#{@merchant_1.id}" do
        click_button "Disable"
      end 
      
      @merchant_1.reload
      @item_1.reload
      @item_2.reload
      @item_3.reload
      
      visit '/admin/merchants'
      
      expect(@item_1.active?).to eq(false)
      expect(@item_2.active?).to eq(false)
      
      regular = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(regular)
      
      visit '/items'
      
      expect(page).not_to have_content(@item_1.name)
      expect(page).not_to have_css("img[src*='#{@item_1.image}']")
      expect(page).not_to have_content(@item_2.name)
      expect(page).not_to have_css("img[src*='#{@item_2.image}']")
      expect(page).to have_content(@item_3.name)
      expect(page).to have_css("img[src*='#{@item_3.image}']")
      expect(page).to have_content(@item_4.name)
      expect(page).to have_css("img[src*='#{@item_4.image}']")
    end 
    it "Admin can enable an merchant and it's items" do 
      merchant_3 = create(:random_merchant, status: 1)
      item_5 = create(:random_item, active?: false, merchant_id: merchant_3.id)
      item_6 = create(:random_item, active?: false, merchant_id: merchant_3.id)
      
      expect(merchant_3.status).to eq('disabled')  
      expect(item_5.active?).to eq(false)
      expect(item_6.active?).to eq(false)
      
      visit '/admin/merchants'
      
      within "#merchant-#{merchant_3.id}" do
        click_button 'Enable'
      end 
      
      merchant_3.reload
      item_5.reload
      item_6.reload
      
      expect(merchant_3.status).to eq('enabled')  
      expect(item_5.active?).to eq(true)
      expect(item_6.active?).to eq(true)
      expect(page).to have_content("#{merchant_3.name} has been enabled")
    end 
    it "clicking on 'enabled' button activates that merchant's items" do 
      merchant_3 = create(:random_merchant, status: 1)
      item_5 = create(:random_item, active?: false, merchant_id: merchant_3.id)
      item_6 = create(:random_item, active?: false, merchant_id: merchant_3.id)
      
      expect(merchant_3.status).to eq('disabled')  
      expect(item_5.active?).to eq(false)
      expect(item_6.active?).to eq(false)
      
      visit '/admin/merchants'
      
      within "#merchant-#{merchant_3.id}" do
        click_button 'Enable'
      end 
      
      merchant_3.reload
      item_5.reload
      item_6.reload
      
      regular = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(regular)
      
      visit '/items'
      
      expect(page).to have_content(item_5.name)
      expect(page).to have_css("img[src*='#{item_5.image}']")
      expect(page).to have_content(item_6.name)
      expect(page).to have_css("img[src*='#{item_6.image}']")
    end 
  end
end
