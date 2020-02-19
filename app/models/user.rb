class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip_code, :password
  validates :email_address, presence: true, uniqueness: true
  enum role: %w(default admin)
end