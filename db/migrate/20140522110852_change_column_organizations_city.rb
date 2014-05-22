class ChangeColumnOrganizationsCity < ActiveRecord::Migration
  def up
    change_column :organizations, :city, :string, null: false
  end

  def down
    change_column :organizations, :city, :string
  end
end
