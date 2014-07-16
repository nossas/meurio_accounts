class RemoveMailchimpEuidIndexFromUser < ActiveRecord::Migration
  def up
    remove_index :users, :mailchimp_euid
  end

  def down
    add_index :users, :mailchimp_euid
  end
end
