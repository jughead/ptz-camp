class CreatePublicFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :public_files do |t|
      t.text :title
      t.string :data

      t.timestamps
    end
  end
end
