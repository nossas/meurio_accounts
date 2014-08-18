class AddFacebookSubscribersCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_subscribers_count, :integer
  end
end
