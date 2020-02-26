describe "As a merchant", type: :feature do
  describe "when I visit an order show page from my dashboard"
    before :each do
      @merchant_user_1 = create(:merchant_user)
      @merchant_user_2 = create(:merchant_user)
      @user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user_1)

      @item_1 = create(:random_item, merchant: @merchant_user_1.merchant)
      @item_2 = create(:random_item, merchant: @merchant_user_1.merchant)
      @item_3 = create(:random_item, merchant: @merchant_user_2.merchant)
      
      @order = create(:random_order, user: @user.user)
    end

    it "I see the user info that created the order, and only my items from the order" do
      
    end
end