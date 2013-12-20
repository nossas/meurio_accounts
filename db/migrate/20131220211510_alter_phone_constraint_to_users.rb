class AlterPhoneConstraintToUsers < ActiveRecord::Migration
  def up
    execute "ALTER TABLE users DROP CONSTRAINT proper_phone"
    execute "ALTER TABLE users ADD CONSTRAINT proper_phone CHECK (phone ~* '[(]{1}[0-9]{2}[)]{1} [0-9]{8,9}' or phone = '');"
  end
  
  def down
    execute "ALTER TABLE users DROP CONSTRAINT proper_phone"
    execute "ALTER TABLE users ADD CONSTRAINT proper_phone CHECK (phone ~* '[(]{1}[0-9]{2}[)]{1} [0-9]{8,9}');"
  end
end
