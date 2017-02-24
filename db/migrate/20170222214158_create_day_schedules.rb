class CreateDaySchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :day_schedules do |t|
      t.references :camp, foreign_key: true, null: false
      t.date :date, null: false
      t.text :content

      t.timestamps
    end
  end
end
