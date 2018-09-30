class RenameProvidersToOrganizations < ActiveRecord::Migration[5.2]
  def change
    rename_table :providers, :organizations
  end
end
