class Organization < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :org_admins

  def redemptions
    projects_ids = projects.map(&:id)
    Redemption.where(project_id: projects_ids)
  end

  def nro_of_projects
    projects.count
  end

  def nro_of_redemptions
    redemptions.count
  end
end
