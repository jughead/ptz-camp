class AddFrontPageToCamps < ActiveRecord::Migration[5.0]
  def change
    add_column :camps, :front_page, :text
  end
end
