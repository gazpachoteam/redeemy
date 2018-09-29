class RenameRedeemableToProject < ActiveRecord::Migration[5.2]
  def change
    rename_table :redeemables, :projects
  end
end
