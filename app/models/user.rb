class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates :first_name, :last_name, presence: true
  has_secure_password

end
