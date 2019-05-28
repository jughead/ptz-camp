class AddFlagsToTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :flags, :integer
  end
end
