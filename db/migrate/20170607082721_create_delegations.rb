class CreateDelegations < ActiveRecord::Migration[5.0]
  def change
    create_table :delegations do |t|
      t.references :camp, foreign_key: true
      t.string :name
      t.integer :supervisor_id
      t.integer :max_teams, default: 1

      t.timestamps
    end
  end
end
