require 'date'

class DayToDateMapper

	def initialize(startingDate)
		@startingDate = Date.parse(startingDate)
	end

	def date_of_next(day)
	  day = day.chomp.delete(' ').upcase
	  return Date.today     if 'TODAY' == day
	  return Date.today + 1 if 'TOMORROW' == day

	  date = @startingDate
	  date.step(@startingDate + 7, step=1) { |d| 
	  	return d if dateMatchesDay(d, day)
	  }
	end

	private

	def dateMatchesDay(date, day) 
		case day[0...3]
			when 'SAT'
				return date.saturday?
			when 'SUN'
				return date.sunday?
			when 'MON'
				return date.monday?
			when 'TUE'
				return date.tuesday?
			when 'WED'
				return date.wednesday?
			when 'THU'
				return date.thursday?
			when 'FRI'
				return date.friday?
			else
				raise 'I only understand English Gregorian days of the week'
			end
	end
end