class AddStartAndFinishDatesToCamp < ActiveRecord::Migration[5.0]
  def change
    add_column :camps, :start_date, :date, default: Date.new(Date.current.year, 1, 30)
    add_column :camps, :finish_date, :date, default: Date.new(Date.current.year, 2, 9)
  end
end
