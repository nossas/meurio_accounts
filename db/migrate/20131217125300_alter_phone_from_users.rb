class AlterPhoneFromUsers < ActiveRecord::Migration
  def up
    execute "ALTER TABLE users ADD CONSTRAINT proper_phone CHECK (phone ~* '[(]{1}[0-9]{2}[)]{1} [0-9]{8,9}');"
  end
  
  def down
    execute "ALTER TABLE users DROP CONSTRAINT proper_phone"
  end
end
