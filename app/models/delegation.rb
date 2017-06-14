class Delegation < ApplicationRecord
  belongs_to :camp

  validates :max_teams, numericality: { greater_than: 0 }
end
