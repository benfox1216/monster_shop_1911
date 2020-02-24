require 'rails_helper'

describe "As a visitor" do
  describe "When I visit the registration page" do
    before :each do
      User.create(name: "Danny Moron", address: "456 Uncool St", city: "Colorado Springs", state: "CO", zip_code: "54239", email_address: "uncannydanny@4realz.com", password: "sweetstreet")
      
      @name = "Ben Wolf"
      @address = "123 Cool St"
      @city = "Funky Town"
      @state = "PA"
      @zip = "32789"
      @email = "zeke42069@coolguyclub.com"
      @password = "11111"
      @confirm_pw = "11111"
      
      visit '/items'
      
      within '.topnav' do
        click_link 'Register'
      end
    end
    
    it "I can create a new profile" do
      expect(current_path).to eq("/register")
      
      fill_in :name, with: @name
      fill_in :address, with: @address
      fill_in :city, with: @city
      fill_in :state, with: @state
      fill_in :zip_code, with: @zip
      fill_in :email_address, with: @email
      fill_in :password, with: @password
      fill_in :confirm_password, with: @confirm_pw
      
      click_button 'Register'
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You are now registered and logged in")
    end
    
    it "I cannot create a new user if there is missing info" do
      fill_in :name, with: @name
      fill_in :address, with: @address
      fill_in :city, with: @city
      fill_in :state, with: @state
      fill_in :password, with: @password
      fill_in :confirm_password, with: @confirm_pw
      
      click_button 'Register'
      expect(current_path).to eq("/register")
      expect(page).to have_content("Zip code can't be blank and Email address can't be blank")
    end
    
    it "I cannot create a profile using an existing email address" do
      fill_in :name, with: @name
      fill_in :address, with: @address
      fill_in :city, with: @city
      fill_in :state, with: @state
      fill_in :zip_code, with: @zip
      fill_in :email_address, with: "uncannydanny@4realz.com"
      fill_in :password, with: @password
      fill_in :confirm_password, with: @confirm_pw
      
      click_button 'Register'
      # expect(current_path).to eq("/register")       
      expect(page).to have_content("Email address has already been taken")
    end
  end
end