class Role < ApplicationRecord
  has_and_belongs_to_many :participants, :join_table => :participants_roles
  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource,
             :polymorphic => true,
             :optional => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true
  scopify
end
