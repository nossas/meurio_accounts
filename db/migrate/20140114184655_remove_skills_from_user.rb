class RemoveSkillsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :skills, :integer
  end
end
