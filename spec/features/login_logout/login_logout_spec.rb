require 'rails_helper'

describe "As a visitor when I visit the login path" do
    it "I see a field to enter my email address and password" do
        visit login_path

        email = 'danmoron31@gmail.com'
        password = '123goodpassword'
        
        fill_in :email, with: email
        fill_in :password, with: password

        expect(page).to have_button("Login")
    end
  
    describe "regular user" do
        it "When I login, I am redirected to my profile page" do 
            visit login_path
            user = create(:regular_user)

            biding.pry

            # fill_in :email, with: user.email
            # fill_in :password, with: user.password
        
        end
    end 
  
    # describe " merchant user" do
    #     it "When I login, I am redirected to my merchant dashboard page" do 
    #         visit login_path

    #         email = 'danmoron31@gmail.com'
    #         password = '123goodpassword'
            
    #         fill_in :email, with: email
    #         fill_in :password, with: password
    #     end
    # end 

    # describe "admin user" do
    #     it "When I login, I am redirected to my admin dashboard page" do 
    #         visit login_path

    #         email = 'danmoron31@gmail.com'
    #         password = '123goodpassword'
            
    #         fill_in :email, with: email
    #         fill_in :password, with: password
    #     end
    # end 
  
end



# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in