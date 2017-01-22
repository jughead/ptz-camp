class AddTelegramUserIdToTelegramUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :telegram_users do |t|
    	t.integer :telegram_user_id, :default => nil
    end
  end
end
 