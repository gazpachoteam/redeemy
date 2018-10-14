class AddFeaturedToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :featured, :boolean, null: false, default: false
  end
end
