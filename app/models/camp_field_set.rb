class CampFieldSet < ApplicationRecord
  belongs_to :camp
  validates :camp, presence: true
end
