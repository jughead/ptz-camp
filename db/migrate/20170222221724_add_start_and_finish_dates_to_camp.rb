class AddStartAndFinishDatesToCamp < ActiveRecord::Migration[5.0]
  def change
    add_column :camps, :start_date, :date, null: false, default: '2017-01-30'
    add_column :camps, :finish_date, :date, null: false, default: '2017-02-09'
  end
end
