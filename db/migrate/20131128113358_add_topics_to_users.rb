class AddTopicsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :topics, :integer
  end
end
