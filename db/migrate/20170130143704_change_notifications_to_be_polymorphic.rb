class ChangeNotificationsToBePolymorphic < ActiveRecord::Migration[5.0]
  def up
    change_column :telegram_users, :telegram_chat_id, :bigint, null: false
    change_column :telegram_groups, :telegram_chat_id, :bigint, null: false

    add_column :notifications, :recipient_type, :string
    add_column :notifications, :recipient_id, :integer
    ActiveRecord::Base.connection.execute (<<-SQL).squish
      UPDATE notifications SET recipient_type = 'TelegramUser', recipient_id = telegram_user_id;
    SQL
    add_index :notifications, [:recipient_type, :recipient_id, :message_id],
      name: 'index_recipient_message_on_notifications_uniq',
      unique: true
    change_column :notifications, :recipient_type, :string, null: false
    change_column :notifications, :recipient_id, :integer, null: false
    remove_column :notifications, :telegram_user_id
  end

  def down
    add_column :notifications, :telegram_user_id, :integer
    ActiveRecord::Base.connection.execute (<<-SQL).squish
      UPDATE notifications SET telegram_user_id = recipient_id;
    SQL
    change_column :notifications, :telegram_user_id, :integer, null: false, index: true
    remove_column :notifications, :recipient_type
    remove_column :notifications, :recipient_id

    change_column :telegram_users, :telegram_chat_id, :integer, null: false
    change_column :telegram_groups, :telegram_chat_id, :integer, null: false
  end
end
