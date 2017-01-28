class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :message, index: true
      t.references :telegram_user, index: true
      t.timestamp :sent_at

      t.timestamps
    end
    add_index :notifications, [:message_id, :telegram_user_id], unique: true
  end
end
