class AlterFirstNameFromUsers < ActiveRecord::Migration
  def up
    change_column :users, :first_name, :string, :null => false
  end

  def down
    change_column :users, :first_name, :string
  end
end
