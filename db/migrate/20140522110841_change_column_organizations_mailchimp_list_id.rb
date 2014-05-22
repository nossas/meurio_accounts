class ChangeColumnOrganizationsMailchimpListId < ActiveRecord::Migration
  def up
    change_column :organizations, :mailchimp_list_id, :string, null: false
  end

  def down
    change_column :organizations, :mailchimp_list_id, :string
  end
end
