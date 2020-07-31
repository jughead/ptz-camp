class CreateCampFieldSets < ActiveRecord::Migration[5.1]
  def change
    create_table :camp_field_sets do |t|
      t.references :camp, index: true, null: false, foreign_key: true
      t.jsonb :fields
      t.timestamps
    end
  end
end
