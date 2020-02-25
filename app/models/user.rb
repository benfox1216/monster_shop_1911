class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip_code
  validates_presence_of :password, require: true
  validates_presence_of :email_address
  validates_uniqueness_of :email_address
  has_secure_password
  enum role: %w(default admin merchant)
  has_many :orders
  validates :merchant, presence: true, if: :merchant?
  belongs_to :merchant, optional: true

  def has_orders?
    !orders.empty?
  end
end
