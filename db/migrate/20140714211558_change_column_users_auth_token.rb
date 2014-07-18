class ChangeColumnUsersAuthToken < ActiveRecord::Migration
  def up
    change_column :users, :auth_token, :string, null: false
  end

  def down
    change_column :users, :auth_token, :string
  end
end
