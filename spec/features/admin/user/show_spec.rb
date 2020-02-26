require 'rails_helper'

describe "As an admin user" do
  describe "When I visit a user's profile page " do
    before :each do
      @admin = create(:admin_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      @user_1 = create(:regular_user)      
    end
    
    it "I see all of my information besides my password, and a link to edit my data" do
      visit '/admin/users'

      click_link "#{@user_1.name}"

      expect(current_path).to eq("/admin/users/#{@user_1.id}")  

      expect(page).to have_content("User Name: #{@user_1.name}")
      expect(page).to have_content("Address: #{@user_1.address}")
      expect(page).to have_content("City: #{@user_1.city}")
      expect(page).to have_content("State: #{@user_1.state}")
      expect(page).to have_content("Zip Code: #{@user_1.zip_code}")
      expect(page).to have_content("Email: #{@user_1.email_address}")
      
      expect(page).to_not have_link("Edit Profile")
    end
  end
end



