class AlterLastNameFromUsers < ActiveRecord::Migration
  def up
    change_column :users, :last_name, :string, :null => false
  end

  def down
    change_column :users, :last_name, :string
  end
end
