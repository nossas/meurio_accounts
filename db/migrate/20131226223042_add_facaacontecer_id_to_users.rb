class AddFacaacontecerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facaacontecer_id, :integer
  end
end
