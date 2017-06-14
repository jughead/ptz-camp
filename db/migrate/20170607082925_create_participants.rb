class CreateParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :participants do |t|
      t.references :camp, foreign_key: true
      t.references :delegation, foreign_key: true
      t.references :user, foreign_key: true
      t.date :arrival
      t.date :departure
      t.jsonb :personal
      t.string :passport_scan
      t.integer :tshirt
      # t.references :hotel, foreign_key: true

      t.timestamps
    end
  end
end
