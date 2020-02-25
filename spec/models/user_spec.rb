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
    it {should define_enum_for(:role).with_values([:regular_user, :merchant_user, :admin_user])}
  end

  describe "relationships" do
    it {should have_many :orders}
    it {should belong_to(:merchant).optional}
  end
end
