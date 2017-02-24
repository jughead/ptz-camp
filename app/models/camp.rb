class Camp < ApplicationRecord
  validates :title, presence: true
  validates :telegram_intro, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :finish_date, presence: true

  add_command :create_day_schedules
end
