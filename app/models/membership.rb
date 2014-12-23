class Membership < ActiveRecord::Base

  validates :user, presence: true
  validates :user, uniqueness: {scope: :project, message: "has already been added"}
  validates :role, presence: true

  belongs_to :project
  belongs_to :user

  before_destroy :ensure_not_last_owner

  private

  def ensure_not_last_owner
    if role == 'owner' && project.memberships.where(:role => 'owner').count <= 1
      errors.add(:user, "cannot be removed as they are the last owner of the project")
      return false
    end
  end
end
