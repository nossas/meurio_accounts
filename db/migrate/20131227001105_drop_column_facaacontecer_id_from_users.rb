class DropColumnFacaacontecerIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :facaacontecer_id, :integer
  end
end
