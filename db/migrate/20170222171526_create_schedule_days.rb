class CreateScheduleDays < ActiveRecord::Migration[5.0]
  def change
    create_table :schedule_days do |t|
      t.references :camp, foreign_key: true
      t.date :date
      t.text :content

      t.timestamps
    end
  end
end
