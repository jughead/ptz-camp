class Schedule < Struct.new(:camp)
  include FrontUrlExtension

  def days
    camp.day_schedules
  end
end
