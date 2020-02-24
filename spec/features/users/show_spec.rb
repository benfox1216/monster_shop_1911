require 'rails_helper'

describe "As a registered user" do
  describe "When I visit my profile page" do
    before :each do
      @user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit profile_path
    end
    
    it "I see all of my information besides my password, and a link to edit my data" do
      expect(page).to have_content("My Name: #{@user.name}")
      expect(page).to have_content("Address: #{@user.address}")
      expect(page).to have_content("City: #{@user.city}")
      expect(page).to have_content("State: #{@user.state}")
      expect(page).to have_content("Zip Code: #{@user.zip_code}")
      expect(page).to have_content("Email: #{@user.email_address}")
      
      expect(page).to have_link("Edit Profile")
    end
    
    it "I see a link to my orders, only if I have them" do
      expect(page).to_not have_link("My Orders")
      
      order_1 = @user.orders.create!(name: "Jack", address: "123 Heart Pl", city: "Reno", state: "NV", zip: "19443")
      visit profile_path
      click_link "My Orders"
      expect(current_path).to eq("/profile/orders")
    end
    
    it "text" do
      
    end
  end
end


