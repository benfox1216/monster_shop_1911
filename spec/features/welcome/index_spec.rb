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
  end
end
