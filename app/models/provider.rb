class Provider < ApplicationRecord
  has_many :projects, dependent: :destroy

  def redemptions
    projects_ids = projects.map(&:id)
    Redemption.where(project_id: projects_ids)
  end
end
