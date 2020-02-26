require 'rails_helper'

describe "As an admin user " do
  describe "I visit '/admin/users'" do
    before(:each) do
      @user_1 = create(:regular_user)      
      @user_2 = create(:regular_user)      
      @user_3 = create(:regular_user)      
      @user_4 = create(:regular_user) 
      @admin = create(:admin_user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)  
    end
    
    it "I see all the users and their attributes" do
      visit '/'

      click_link 'All Users'

      expect(current_path).to eq('/admin/users')  

      within "#user-#{@user_1.id}" do
        expect(page).to have_content(@user_1.name) 
        expect(page).to have_content(@user_1.created_at) 
        expect(page).to have_content(@user_1.role) 
      end 

      within "#user-#{@user_2.id}" do
        expect(page).to have_content(@user_2.name) 
        expect(page).to have_content(@user_2.created_at) 
        expect(page).to have_content(@user_2.role) 
      end

      within "#user-#{@user_3.id}" do
        expect(page).to have_content(@user_3.name) 
        expect(page).to have_content(@user_3.created_at) 
        expect(page).to have_content(@user_3.role) 
      end

      within "#user-#{@user_4.id}" do
        expect(page).to have_content(@user_4.name) 
        expect(page).to have_content(@user_4.created_at) 
        expect(page).to have_content(@user_4.role) 
      end 

      expect(page).to_not have_content(@admin.name)
    end
  end
end
