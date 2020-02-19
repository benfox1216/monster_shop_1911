class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip_code, :email_address, :password
end