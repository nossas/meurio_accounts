class AddMailchimpEuidIndexToUser < ActiveRecord::Migration
  def up
    add_index :users, :mailchimp_euid
  end

  def down
    remove_index :users, :mailchimp_euid
  end
end
