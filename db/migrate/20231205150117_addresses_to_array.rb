class AddressesToArray < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :important_addresses, :string
    add_column :users, :important_addresses, :string, array: true, default: []
  end
end
