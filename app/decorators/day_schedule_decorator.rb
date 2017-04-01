# frozen_string_literal: true
class DayScheduleDecorator < ApplicationDecorator
  def day_number
    (object.date - object.camp.start_date).to_i + 1
  end

  def title
    result = object.date.strftime("%B, %d, day #{day_number} (%A)")
    result << ', day off' if day_number % 4 == 0
    result
  end

  def content
    # TODO: apply events
    object.content
  end
end
