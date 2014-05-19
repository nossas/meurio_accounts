class RenameTableAccountsToOrganizations < ActiveRecord::Migration
  def change
    rename_table :accounts, :organizations
  end
end
