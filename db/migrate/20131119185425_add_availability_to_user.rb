class AddAvailabilityToUser < ActiveRecord::Migration
  def change
    add_column :users, :local_availability, :hstore
    add_column :users, :remote_availability, :hstore
  end
end
