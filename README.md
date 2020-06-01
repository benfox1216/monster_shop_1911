# Monster Shop
BE Mod 2 Week 4/5 Group Project

## Background and Description

"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will automatically set the order status to "shipped". Each user role will have access to some or all CRUD functionality for application models.

This project was the penultimate assignment in Module 2 of the Turing School's backend engineering program. Undertaken as a group effort, the three of us worked from a starting brownfield for a period of eight days to implement basic e-commerce functions on this application including CRUD functionality, log in and authentication, authorization (for four different user types), cart functionality, and statistics for multiple aspects of the site.

View Monster Shop on Heroku [here](https://monster-shop-group.herokuapp.com/)

## Implementation

To implement Monster Shop locally, run the following commands:

<code>git clone https://github.com/benfox1216/monster_shop_1911.git</code>

<code>cd monster_shop_1911</code>

<code>gem install bundler</code>

<code>bundle update</code>

<code>rake db:{drop,create,migrate,seed}</code>

Create a new [heroku](https://id.heroku.com/login) app and connect to your local monster shop repository with:

<code>heroku git:remot -a your_heroku_app_name</code>

Deploy Monster Shop from heroku.

## Schema Design
![Image of Schema Design](https://i.imgur.com/32jB4Lz.png)

## Code Snippets

One design decision we made was to have a separate controller for the login functionality. Below is our create method for that controller:

```ruby

def create
  user = User.find_by(email_address: params[:email])
  if user.authenticate(params[:password])
    if user.default?
      redirect_to user_path
    elsif user.merchant?
      redirect_to merchant_path
    elsif user.admin?
      redirect_to admin_path
    end
    session[:user_id] = user.id
    flash[:success] = "#{user.name}, you are now logged in!"
  else
    flash[:error] = 'Invalid credentials'
    redirect_to login_path
  end
end

```

The item class was also something that took some intricate organization, as it has many validations and relationships. Below is our description within the item model of those validations and relationships:

```ruby

class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :inventory, greater_than_or_equal_to: 0
end

```

## Contributors

[Ezekiel Clark](https://github.com/Yetidancer)

[Ben Fox](https://github.com/benfox1216)

[Daniel Moran](https://github.com/danmoran-pro)

## Learning Goals

### Rails
* Create routes for namespaced routes
* Implement partials to break a page into reusable components
* Use Sessions to store information about a user and implement login/logout functionality
* Use filters (e.g. `before_action`) in a Rails controller
* Limit functionality to authorized users
* Use BCrypt to hash user passwords before storing in the database

### ActiveRecord
* Use built-in ActiveRecord methods to join multiple tables of data, calculate statistics and build collections of data grouped by one or more attributes

### Databases
* Design and diagram a Database Schema
* Write raw SQL queries (as a debugging tool for AR)

## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- must use 'bcrypt' for authentication
- all controller and model code must be tested via feature tests and model tests, respectively
- must use good GitHub branching, team code reviews via GitHub comments, and use of a project planning tool like github projects
- must include a thorough README to describe their project

## User Roles

1. Visitor - this type of user is anonymously browsing our site and is not logged in
2. Regular User - this user is registered and logged in to the application while performing their work; can place items in a cart and create an order
3. Merchant Employee - this user works for a merchant. They can fulfill orders on behalf of their merchant. They also have the same permissions as a regular user (adding items to a cart and checking out)
4. Admin User - a registered user who has "superuser" access to all areas of the application; user is logged in to perform their work

## Order Status

1. 'pending' means a user has placed items in a cart and "checked out" to create an order, merchants may or may not have fulfilled any items yet
2. 'packaged' means all merchants have fulfilled their items for the order, and has been packaged and ready to ship
3. 'shipped' means an admin has 'shipped' a package and can no longer be cancelled by a user
4. 'cancelled' - only 'pending' and 'packaged' orders can be cancelled
