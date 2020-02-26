require 'rails_helper'

describe "Test Application Controller", type: :model do
  describe "instance methods" do
    before(:each) do
      @user = create(:regular_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    xit "#cart" do
      expect(@user.cart).to eq(3.0)
    end
  end
end
