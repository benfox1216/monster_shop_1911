require 'rails_helper'

RSpec.describe 'merchant index page', type: :feature do
  describe 'As a user' do
    it 'I can go to the welcome page' do
      visit '/'

      expect(page).to have_content("WELCOME TO THE JUNGLE")
    end

    it 'can access universal links' do
      visit '/'

      expect(page).to have_link("Home")
      expect(page).to have_link("All Merchants")
      expect(page).to have_link("All Items")
      expect(page).to have_content("Cart: 0")
      expect(page).to have_link("Login")
      expect(page).to have_link("Register")
    end

    it 'cannot see profile and logout if not logged in' do
      user = create(:regular_user, email: "ben@fox.com", password: "ilovetrucks")

      expect(page).to_not have_link("Profile")
      expect(page).to_not have_link("Logout")

      visit '/login'

      fill_in :email, with: "ben@fox.com"
      fill_in :password, with: "ilovetrucks"

      click_button "Login"

      expect(page).to have_link("Profile")
      expect(page).to have_link("Logout")
    end
  end
end
