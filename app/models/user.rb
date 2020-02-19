class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :email, :password
end