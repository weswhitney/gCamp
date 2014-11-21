class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates :first_name, :last_name, presence: true
  has_secure_password
  has_many :memberships
  has_many :users, through: :memberships

  def full_name
    self.first_name + ' ' + self.last_name
  end

end
