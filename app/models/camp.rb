class Camp < ApplicationRecord
  has_many :day_schedules, dependent: :destroy
  has_many :delegations, dependent: :destroy

  after_create :create_day_schedules

  validates :title, presence: true
  validates :telegram_intro, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :finish_date, presence: true

  add_command :create_day_schedules
  add_command :build_participant

  def schedule
    @schedule ||= Schedule.new(self)
  end
end
