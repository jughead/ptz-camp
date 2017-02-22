class DaySchedule < ApplicationRecord
  belongs_to :camp
  validates :content, presence: true
  validates :date, presence: true
  validates :camp, presence: true
end
