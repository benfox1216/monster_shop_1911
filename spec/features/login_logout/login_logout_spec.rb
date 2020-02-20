require 'rails_helper'

describe "When I login, I am redirected to my profile page" do 
    # describe "As regular user" do
    #     it "When I login, I am redirected to my merchant dashboard page" do 
    #         visit login_path

    #         user = create(:regular_user)
    
    #         fill_in :email, with: user.email_address
    #         fill_in :password, with: user.password
            
    #         click_button "Login"

    #         expect(current_path).to eq(user_path)
    #         expect(page).to have_content("#{user.name}, you are now logged in!")
    #     end
    # end

    # describe "As merchant user" do
    #     it "When I login, I am redirected to my merchant dashboard page" do 
    #         visit login_path
            
    #         merchant = create(:merchant_user)
    
    #         fill_in :email, with: merchant.email_address
    #         fill_in :password, with: merchant.password
            
    #         click_button "Login"

    #         expect(current_path).to eq(merchants_path)
    #         expect(page).to have_content("#{merchant.name}, you are now logged in!")
    #     end
    # end
    describe "admin user" do
        it "When I login, I am redirected to my merchant dashboard page" do 
            visit login_path

            admin = create(:admin_user)
    
            fill_in :email, with: admin.email_address
            fill_in :password, with: admin.password
            
            click_button 'Login'

            expect(current_path).to eq(admin_path)
            expect(page).to have_content("#{admin.name}, you are now logged in!")
        end
    end 
end 


