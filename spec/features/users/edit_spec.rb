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
      expect(current_path).to eq(password_edit_path)
      
      fill_in :password, with: "new pass"
      fill_in :confirm_password, with: "new pass"
      
      click_on("Update Password")
      
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Your password has been updated.")
    end 
  end 

  describe "As merchant user" do      
    describe "When I visit my profile page, I see a link to edit my profile data" do
      before(:each) do 
        merchant = create(:merchant_user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant) 
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
        expect(current_path).to eq(password_edit_path)
        
        fill_in :password, with: "new pass"
        fill_in :confirm_password, with: "new pass"
        
        click_on("Update Password")
        
        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Your password has been updated.")
      end
    end 
  end  

  describe "As an Admin user" do      
    describe "When I visit my profile page, I see a link to edit my profile data" do
      before(:each) do 
        @admin = create(:admin_user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin) 
      end 

      it "clicking on the link takes me to an edit form" do
        admin = create(:admin_user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin) 

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
        expect(current_path).to eq(password_edit_path)
        
        fill_in :password, with: "new pass"
        fill_in :confirm_password, with: "new pass"
        
        click_on("Update Password")
        
        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Your password has been updated.")
      end
      
      it "wont update if passwords don't match " do
        visit profile_path
        click_link("Edit My Password") 
        expect(current_path).to eq(password_edit_path)
        
        fill_in :password, with: "new pass"
        fill_in :confirm_password, with: "ne pass"
        
        click_on("Update Password")
        
        expect(page).to have_content("Password and password confirmation do not match.")
      end
      
      it "Can not use duplicated email " do
        user_2 = create(:regular_user, email_address: "ben@fox.com")
        visit profile_path

        click_link("Edit Profile")  

        fill_in :email_address, with: "ben@fox.com"
      
        click_on "Submit"
        expect(page).to have_content("That email address is already in use.")
      end
    end 
  end      
end


# User Story 22, User Editing Profile Data must have unique Email address

# As a registered user
# When I attempt to edit my profile data
# If I try to change my email address to one that belongs to another user
# When I submit the form
# Then I am returned to the profile edit page
# And I see a flash message telling me that email address is already in use