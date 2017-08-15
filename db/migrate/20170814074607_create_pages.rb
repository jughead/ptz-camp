class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.references :camp, foreign_key: true
      t.integer :state
      t.text :title
      t.text :content
      t.string :slug
      t.integer :order

      t.timestamps
    end
  end
end
