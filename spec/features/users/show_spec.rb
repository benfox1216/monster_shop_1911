require 'rails_helper'

describe "As a registered user" do
    describe "When I visit my profile page, I see all of my information besides my data" do
        it "And I see a link to edit my profile data" do
            user = create(:regular_user)
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

            visit profile_path
            expect(page).to have_content("My Name: #{user.name}") 
            expect(page).to have_content("Address: #{user.address}") 
            expect(page).to have_content("City: #{user.city}") 
            expect(page).to have_content("State: #{user.state}") 
            expect(page).to have_content("Zip Code: #{user.zip_code}") 
            expect(page).to have_content("Email: #{user.email_address}") 

            expect(page).to have_link("Edit Profile")  
        end
    end
end


