require 'rails_helper'

describe "something to be performed" do
  context "under condition" do
    it "behaves like" do
      admin = create(:admin_user)
      user = create(:regular_user)
      user_2 = create(:regular_user)
      merchant = create(:random_merchant)
      merchant_2 = create(:random_merchant)
      item_1 = create(:random_item, merchant_id: merchant.id)
      item_2 = create(:random_item, merchant_id: merchant.id)
      item_3 = create(:random_item, merchant_id: merchant_2.id)
      item_4 = create(:random_item, merchant_id: merchant_2.id)
    end
  end
end
