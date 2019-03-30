
class TemplateTransformer

	def initialize(config, dayToDateMapper)
		@config = config
		@dateColumn = @config[:dateColumn]
		@dayToDateMapper = dayToDateMapper
	end

	def convert(line) 
		columns = split_into_columns(line)
		begin
			replace_day_of_week_with_date(columns)
			columns[@dateColumn] = columns[@dateColumn].center(@config[:dateColumnWidth])
			line = columns.join(@config[:columnSeparator])
		rescue
			# can't parse the day of the week or the column of the date field is wrong
		end
		line
	end

private

	def split_into_columns(line)
		line.split(@config[:columnSeparator])
	end

	def replace_day_of_week_with_date(columns)
		dayOfWeek = columns[@dateColumn]
		date = @dayToDateMapper.date_of_next(dayOfWeek)
		columns[@dateColumn] = date.strftime(@config[:dateTimeFormat])
	end
end