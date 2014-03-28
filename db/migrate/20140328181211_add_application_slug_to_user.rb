class AddApplicationSlugToUser < ActiveRecord::Migration
  def change
    add_column :users, :application_slug, :string
  end
end
