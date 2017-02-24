class Camps::CreateDaySchedulesCommand
  def initialize(camp)
    @camp = camp
  end

  def execute
    start = @camp.start_date
    finish = @camp.finish_date
    if finish - start < 1.month
      day = start
      while day <= finish do
        # may be add here a transaction?
        # TODO: update content
        DaySchedule.create!(camp: @camp, date: day, content: "Content")
        day = day.next_day
      end
    else
      # raise some error
    end
  end
end
