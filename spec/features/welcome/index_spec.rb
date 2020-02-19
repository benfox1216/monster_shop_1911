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
      visit '/'

      expect(page).to_not have_link("Profile")
      expect(page).to_not have_link("Logout")

      user = User.create(name: "Yogi Bear", address: "Sherwood Forest", city: "Londontown", state: "Denial", zip: "20203", email: "pickanickbasket@booboo.com", password: "yumyumyum")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(page).to have_link("Profile")
      expect(page).to have_link("Logout")
    end
  end
end
