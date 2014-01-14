class MigrateSkillsDataToSkillsTemp < ActiveRecord::Migration
  def up
    User.all.each { |user| user.update_attributes skills_temp: user.skills }
  end

  def down
    # Before running this, you might want to add "bitmask :skills, as: SKILL_OPTIONS" to the User model; otherwise, skills will become nil
    User.all.each { |user| user.update_attributes skills: user.skills_temp }
  end
end
