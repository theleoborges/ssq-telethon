class User < ActiveRecord::Base
  devise :database_authenticatable

  attr_accessible :email, :password, :password_confirmation
end
