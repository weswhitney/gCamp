class Project < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, case_sensitive: false

  has_many :tasks, dependent: :destroy

  has_many :memberships, dependent: :destroy

  has_many :users, through: :memberships

  def owner?(project)
    admin? || memberships.where(project_id: project.id, role:"owner").present?
  end

  def member?(project)
    projects.include?(project)
  end

end
