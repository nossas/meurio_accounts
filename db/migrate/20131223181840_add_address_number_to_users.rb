class AddAddressNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address_number, :string
  end
end
