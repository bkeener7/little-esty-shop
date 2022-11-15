require './app/poros/holiday'
require './app/services/holiday_service'

class HolidaySearch
  def upcoming_holidays
    service.holidays.map { |holiday| Holiday.new(holiday) }
  end

  def service
    HolidayService.new
  end
end
