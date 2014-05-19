class AddIndexMembershipsOrganizationIdAndUserIdUniq < ActiveRecord::Migration
  def change
    add_index(:memberships, [:organization_id, :user_id], unique: true)
  end
end
