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
            save_and_open_page
        end 
    end      
end