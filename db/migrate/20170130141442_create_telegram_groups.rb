class CreateTelegramGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :telegram_groups do |t|
      t.integer :telegram_chat_id, index: true, null: false
      t.string :title
      t.timestamps
    end
  end
end
