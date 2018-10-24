class Project < ApplicationRecord
  belongs_to :organization
  has_many :pictures
  has_many :categories_projects
  has_many :categories, through: :categories_projects

  scope :featured, -> { where(featured: true) }

  def self.by_category(category_id)
    Project.joins(:categories).where("categories.id = ?", category_id)
  end
end
