class AddRegistrationToCamps < ActiveRecord::Migration[5.0]
  def change
    add_column :camps, :registration, :integer
    Camp.update_all(registration: 1)
    add_index :camps, :registration
  end
end
