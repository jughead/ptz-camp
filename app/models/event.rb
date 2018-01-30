class Event < ApplicationRecord
  belongs_to :camp
  has_many :restrictions, class_name: 'EventRestriction', dependent: :destroy, foreign_key: :event1_id
  has_many :restricted_events, through: :restrictions, source: :event2, dependent: :destroy
  has_many :participations, class_name: 'EventParticipation', dependent: :destroy
  has_many :participants, through: :participations

  validates :name, presence: true
  validates :description, presence: true
  validates :count_limit, presence: true, numericality: { greater_than: 0 }
end
