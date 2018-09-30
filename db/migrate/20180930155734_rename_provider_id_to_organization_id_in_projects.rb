class RenameProviderIdToOrganizationIdInProjects < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :provider_id, :organization_id
  end
end
