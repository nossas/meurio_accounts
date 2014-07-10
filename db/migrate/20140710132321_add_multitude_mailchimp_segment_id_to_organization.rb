class AddMultitudeMailchimpSegmentIdToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :multitude_mailchimp_segment_id, :string, foreign_key: false
  end
end
