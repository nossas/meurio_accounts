class AddAddressExtraToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address_extra, :string
  end
end
