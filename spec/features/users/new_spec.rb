require 'rails_helper'

describe "As a visitor" do
  describe "When I visit the registration page" do
    before :each do
      User.create(name: "Danny Moron", address: "456 Uncool St", city: "Colorado Springs", state: "CO", zip: "54239", email: "uncannydanny@4realz.com", password: "sweetstreet")
      
      @name = "Ben Wolf"
      @address = "123 Cool St"
      @city = "Funky Town"
      @state = "PA"
      @zip = "32789"
      @email = "zeke42069@coolguyclub.com"
      @password = "11111"
      @confirm_pw = "11111"
    end
    
    it "I can create a new profile" do
      visit '/items'
      click_link 'Register'
      expect(current_path).to eq("/register")
      
      fill_in "Name", with: @name
      fill_in "Address", with: @address
      fill_in "City", with: @city
      fill_in "State", with: @state
      fill_in "Zip Code", with: @zip
      fill_in "Email Address", with: @email
      fill_in "Password", with: @password
      fill_in "Confirm Password", with: @confirm_pw
      
      user = User.last
      
      click_button 'Register'
      expect(current_path).to eq("/profile/#{user.id}")
    end
  end
end