class CreateEventRestrictions < ActiveRecord::Migration[5.0]
  def change
    create_table :event_restrictions do |t|
      t.references :event1, foreign_key: { to_table: :events }
      t.references :event2, foreign_key: { to_table: :events }

      t.timestamps
    end
  end
end
