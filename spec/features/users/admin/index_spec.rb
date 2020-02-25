require 'rails_helper'

describe "As an admin user" do
  describe "When I visit my dashboard" do
    before :each do
      @admin = create(:admin_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit '/admin'
    end
    
    it "I can see all the orders in the system, sorted by status" do
      
    end
  end
end