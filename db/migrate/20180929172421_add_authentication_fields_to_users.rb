class AddAuthenticationFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :type, :string
    add_column :users, :phone, :string
    add_column :users, :authentication_token, :string, limit: 30
    add_column :users, :code, :string
  end
end
