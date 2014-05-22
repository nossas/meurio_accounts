class AddIndexOrganizationsCity < ActiveRecord::Migration
  def change
    def change
      add_index :organizations, :city, unique: true
    end
  end
end
