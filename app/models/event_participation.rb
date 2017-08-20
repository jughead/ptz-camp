class EventParticipation < ApplicationRecord
  belongs_to :event, inverse_of: :participations
  belongs_to :participant

  enum state: [:goes, :skips]

  validates :event, presence: true
  validates :participant, presence: true
end
