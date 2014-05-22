class AddIndexOrganizationsMailchimpListId < ActiveRecord::Migration
  def change
    def change
      add_index :organizations, :mailchimp_list_id, unique: true
    end
  end
end
