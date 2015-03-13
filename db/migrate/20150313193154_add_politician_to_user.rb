class AddPoliticianToUser < ActiveRecord::Migration
  def change
    add_column :users, :politician, :boolean
  end
end
