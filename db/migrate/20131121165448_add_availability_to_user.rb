class AddAvailabilityToUser < ActiveRecord::Migration
  def change
    add_column :users, :availability, :integer, limit: 8
  end
end
