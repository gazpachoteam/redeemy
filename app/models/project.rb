class Project < ApplicationRecord
  belongs_to :organization

  scope :featured, -> { where(featured: true) }
end
