class RenameSkillsTempToSkillsInUser < ActiveRecord::Migration
  def change
    rename_column :users, :skills_temp, :skills
  end
end
