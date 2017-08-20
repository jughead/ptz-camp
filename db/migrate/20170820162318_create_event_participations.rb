class CreateEventParticipations < ActiveRecord::Migration[5.0]
  def change
    create_table :event_participations do |t|
      t.references :event, foreign_key: true
      t.references :participant, foreign_key: true
      t.integer :state, null: false

      t.timestamps
    end
  end
end
