class AddMailchimpEuidToUser < ActiveRecord::Migration
  def change
    add_column :users, :mailchimp_euid, :string
    add_index :users, :mailchimp_euid, unique: true
  end
end
