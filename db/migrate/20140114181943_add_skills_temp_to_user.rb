class AddSkillsTempToUser < ActiveRecord::Migration
  def change
    add_column :users, :skills_temp, :string, array: true, default: []    
  end
end
