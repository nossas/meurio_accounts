class ChangeColumnOrganizationsName < ActiveRecord::Migration
  def up
    change_column :organizations, :name, :string, null: false
  end

  def down
    change_column :organizations, :name, :string
  end
end
