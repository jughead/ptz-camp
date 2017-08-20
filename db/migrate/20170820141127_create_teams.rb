class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :camp, foreign_key: true
      t.references :delegation, foreign_key: true
      t.string :name
      t.boolean :with_laptop

      t.timestamps
    end

    add_reference :participants, :team
  end
end
