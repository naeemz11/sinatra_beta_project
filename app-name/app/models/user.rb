class User < ActiveRecord::Base

has_many :orders
has_secure_password #created by the bcrypt gem
end 