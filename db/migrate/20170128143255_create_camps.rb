class CreateCamps < ActiveRecord::Migration[5.0]
  def change
    create_table :camps do |t|
      t.string :title, null: false
      t.string :slug, index: true, null: false
      t.text :telegram_intro, null: false
      t.timestamps index: true
    end
  end
end
