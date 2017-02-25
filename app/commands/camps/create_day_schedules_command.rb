class Camps::CreateDaySchedulesCommand
  DEFAULT_CONTENT = "08:30 – Breakfast\n" +
                    "09:30 – 14:30 – Contest\n" +
                    "14:30 – Lunch\n" +
                    "15:30 – Problem analysis\n" +
                    "19:00 – Dinner\n" +
                    "20:00 – Sports hall / Aquatica"

  def initialize(camp)
    @camp = camp
  end

  def execute
    ActiveRecord::Base.transaction do
      start = @camp.start_date
      finish = @camp.finish_date
      if finish - start < 1.month
        day = start
        while day <= finish do
          DaySchedule.create!(camp: @camp, date: day, content: DEFAULT_CONTENT)
          day = day.next_day
        end
      else
        # raise some error
      end
    end
  end
end
