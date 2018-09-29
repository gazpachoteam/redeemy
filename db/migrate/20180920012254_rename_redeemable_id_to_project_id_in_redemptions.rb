class RenameRedeemableIdToProjectIdInRedemptions < ActiveRecord::Migration[5.2]
  def up
    rename_column :redemptions, :redeemable_id, :project_id
  end

  def down
    rename_column :redemptions, :project_id, :redeemable_id
  end
end
