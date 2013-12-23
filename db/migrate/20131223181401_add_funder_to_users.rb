class AddFunderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :funder, :boolean, default: false
  end
end
