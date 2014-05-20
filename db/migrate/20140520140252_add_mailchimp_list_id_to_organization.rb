class AddMailchimpListIdToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :mailchimp_list_id, :integer, foreign_key: false
  end
end
