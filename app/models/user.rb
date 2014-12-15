class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates :first_name, :last_name, presence: true
  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments, dependent: :nullify

  def full_name
    self.first_name + ' ' + self.last_name
  end

  # def is_owner?(project)
  #   project.memberships.where(role: 'Owner', user_id: id).present?
  # end

end
