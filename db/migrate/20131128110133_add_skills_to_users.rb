class AddSkillsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :skills, :integer
  end
end
