class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :camp, foreign_key: true
      t.string :name
      t.text :description
      t.timestamp :start_at
      t.integer :position, index: true

      t.timestamps
    end
  end
end
