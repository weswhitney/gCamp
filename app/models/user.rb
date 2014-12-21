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

  def owner?(project)
    admin? || memberships.where(project_id: project.id, role:"owner").present?
  end

  def member?(project)
    projects.include?(project)
  end

end
