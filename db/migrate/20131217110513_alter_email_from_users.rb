class AlterEmailFromUsers < ActiveRecord::Migration
  def up
    execute "ALTER TABLE users ADD CONSTRAINT proper_email CHECK (email ~* '([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z\_\-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}');"
  end
  
  def down
    execute "ALTER TABLE users DROP CONSTRAINT proper_email"
  end
end
