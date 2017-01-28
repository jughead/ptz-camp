class CreateBroadcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.text :text
      t.jsonb :options
      t.timestamp :processed_at
      t.integer :sent, default: 0, null: false
      t.integer :notifications_count, default: 0, null: false

      t.timestamps
    end
  end
end
