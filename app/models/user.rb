class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip_code
  validates_presence_of :password, require: true
  validates :email_address, presence: true, uniqueness: true
  has_secure_password
  enum role: %w(default admin merchant)
  has_many :orders
  
  def has_orders?
    !orders.empty?
  end
end
