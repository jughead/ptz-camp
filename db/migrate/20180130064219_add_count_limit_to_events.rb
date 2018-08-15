class AddCountLimitToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :count_limit, :integer, default: 50
  end
end
