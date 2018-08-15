class Team < ApplicationRecord
  belongs_to :camp
  belongs_to :delegation
  has_many :participants

  validates :name, presence: true
  validates :camp, presence: true

  scope :ordered_by_name, -> { order(:name) }

  before_destroy do
    participants.update_all(team_id: nil)
  end
end
