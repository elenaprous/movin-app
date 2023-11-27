class UpdateColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :locations, :gym_info, :gyms_info
    rename_column :users, :important_address, :important_addresses
  end
end
