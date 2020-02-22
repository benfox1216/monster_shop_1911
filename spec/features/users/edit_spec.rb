require 'rails_helper'

describe "As a registered user" do
  describe "When I visit my profile page, I see a link to edit my profile data" do
    before(:each) do 
      @user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user) 
    end 

    it "clicking on the link takes me to an edit form" do
      visit profile_path

      click_link("Edit Profile")  
      expect(current_path).to eq(profile_edit_path)
    end

    it "Can edit profile " do
      visit profile_path

      click_link("Edit Profile")  

      fill_in :name, with: "keyboard"
      
      click_on "Submit"
      
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("keyboard")
      expect(page).to have_content("You have updated your profle!")
    end 

    it "Can edit password " do
      visit profile_path
      click_link("Edit My Password") 
      expect(current_path).to eq(user_password_edit_path)
      
      fill_in :password, with: "new pass"
      fill_in :confirm_password, with: "new pass"
      
      click_on("Update Password")
      
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Your password has been updated.")
    end 
  end      
end