class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable,
         :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :password, :password_confirmation
  # attr_accessible :title, :body
end
