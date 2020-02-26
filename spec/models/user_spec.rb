require 'rails_helper'
describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip_code)}
    it { should validate_presence_of :email_address }
    it { should validate_uniqueness_of :email_address }
    it { should validate_presence_of :password }
    it {should define_enum_for(:role).with_values([:default, :admin, :merchant])}
  end

  describe "relationships" do
    it {should have_many :orders}
    it {should belong_to(:merchant).optional}
  end
  
  describe "methods" do
    before :each do
      @user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
    end
    
    it "#has_orders?" do
      expect(@user.has_orders?).to eq(true)
    end
  end
end
