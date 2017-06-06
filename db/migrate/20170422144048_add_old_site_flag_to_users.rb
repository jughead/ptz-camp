class AddOldSiteFlagToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :old_site, :boolean, default: false, null: false
  end
end
