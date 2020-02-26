require 'rails_helper'

describe "When I login, I am redirected to my designated page" do
  describe "As regular user" do
    it "When I login, I am redirected to my profile page" do
      visit login_path

      user = create(:regular_user)

      fill_in :email, with: user.email_address
      fill_in :password, with: user.password

      click_button "Login"

      expect(current_path).to eq(user_path)
      expect(page).to have_content("#{user.name}, you are now logged in!")
    end
  end

  describe "As merchant user" do
    it "When I login, I am redirected to my merchant dashboard page" do
      visit login_path

      merchant = create(:merchant_user)

      fill_in :email, with: merchant.email_address
      fill_in :password, with: merchant.password

      click_button "Login"
save_and_open_page
      expect(current_path).to eq('/merchant')
      expect(page).to have_content("#{merchant.name}, you are now logged in!")
    end
  end

  describe "admin user" do
    it "When I login, I am redirected to my admin dashboard page" do
      visit login_path

      admin = create(:admin_user)
      
      fill_in :email, with: admin.email_address
      fill_in :password, with: admin.password

      click_button "Login"

      expect(current_path).to eq(admin_path)
      expect(page).to have_content("#{admin.name}, you are now logged in!")
    end
  end

  describe "As a visitor" do
    it "I submit invalid information, then I am redirected to the login page" do
      visit login_path

      user = create(:regular_user)

      fill_in :email, with: user.email_address
      fill_in :password, with: "poop"

      click_button 'Login'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Invalid credentials')
    end
  end

  describe "As a regular user when I visit the login path and I am logged in" do
    it "I am redirected to my profile page" do
      visit login_path

      user = create(:regular_user)

      fill_in :email, with: user.email_address
      fill_in :password, with: user.password

      click_button "Login"

      visit login_path
      expect(current_path).to eq('/')
      expect(page).to have_content("#{user.name}, you already logged in.")
    end
  end

  describe "As a merchant user when I visit the login path and I am logged in" do
    it "I am redirected to my merchant dashboard page" do
      visit login_path

      merchant = create(:merchant_user)

      fill_in :email, with: merchant.email_address
      fill_in :password, with: merchant.password

      click_button "Login"

      visit login_path

      expect(current_path).to eq('/')
      expect(page).to have_content("#{merchant.name}, you already logged in.")
    end
  end

  describe "As a merchant user when I visit the login path and I am logged in" do
    it "I am redirected to my merchant dashboard page" do
      visit login_path

      admin = create(:admin_user)

      fill_in :email, with: admin.email_address
      fill_in :password, with: admin.password

      click_button 'Login'

      visit login_path

      expect(current_path).to eq('/')
      expect(page).to have_content("#{admin.name}, you already logged in.")
    end
  end
    
  describe "As a regular user when I visit the logout path and I am logged out" do
    it "I am redirected to the welcome page and the cart is cleared" do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      visit login_path

      user = create(:regular_user)

      fill_in :email, with: user.email_address
      fill_in :password, with: user.password

      click_button "Login"
      
      visit "/items/#{tire.id}"
      click_on "Add To Cart"
      
      within 'nav' do
          expect(page).to have_content("Cart: 1")
      end

      click_link "Logout"

      expect(current_path).to eq('/')
      expect(page).to have_content("WELCOME TO THE JUNGLE")
      expect(page).to have_content("You have logged out")

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end
  end

  describe "As a merchant user when I visit the logout path and I am logged out" do
    it "I am redirected to the welcome page" do #I dont think merchants have carts? confrim
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

        visit login_path

        merchant = create(:merchant_user)

        fill_in :email, with: merchant.email_address
        fill_in :password, with: merchant.password

        click_button "Login"
        
        visit "/items/#{tire.id}"
        click_on "Add To Cart"
        
        within 'nav' do
          expect(page).to have_content("Cart: 1")
        end

        click_link "Logout"

        expect(current_path).to eq('/')
        expect(page).to have_content("WELCOME TO THE JUNGLE")
        expect(page).to have_content("You have logged out")

        within 'nav' do
          expect(page).to have_content("Cart: 0")
        end
    end
  end
end