class DaySchedule < ApplicationRecord
  belongs_to :camp
  validates :content, presence: true
  validates :date, presence: true
  validates :camp, presence: true

  scope :ordered, -> { order(:date) }

  def current?
    date == Time.use_zone(nil){ Date.current }
  end
end
