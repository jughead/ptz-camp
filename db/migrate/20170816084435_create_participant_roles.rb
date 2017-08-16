class CreateParticipantRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :participants_roles, id: false do |t|
      t.references :participant
      t.references :role
    end

    add_index :participants_roles, [:participant_id, :role_id]

  end
end
