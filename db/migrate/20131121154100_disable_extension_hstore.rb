class DisableExtensionHstore < ActiveRecord::Migration
  def change
    disable_extension "hstore"
  end
end
