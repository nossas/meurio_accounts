class AddAddressStreetToUser < ActiveRecord::Migration
  def change
    add_column :users, :address_street, :string
  end
end
