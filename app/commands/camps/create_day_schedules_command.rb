class Camps::CreateDaySchedulesCommand
  DEFAULT_CONTENT = "08:30 – Breakfast\n" +
                    "09:30 - 14:30 – Contest\n" +
                    "14:30 – Lunch\n" +
                    "15:30 – Problem analysis\n" +
                    "19:00 – Dinner\n" +
                    "20:00 – Sports hall / Aquatica"

  def initialize(camp)
    @camp = camp
  end

  def execute
    start = @camp.start_date
    finish = @camp.finish_date
    ActiveRecord::Base.transaction do
      day = start
      while day <= finish do
        DaySchedule.create!(camp: @camp, date: day, content: DEFAULT_CONTENT)
        day = day.next_day
      end
    end
  end
end
