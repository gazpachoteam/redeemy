class RemoveCategoryFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :category, :string
  end
end
