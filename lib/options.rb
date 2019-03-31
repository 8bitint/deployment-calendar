require 'date'

class Options  # No need for any complexity here...

	def initialize(args)
		@arguments = args
	end

	def args_correct
		return @arguments.count == 1 || @arguments.count == 2
	end

	def print_usage
		print "Usage: gen-deployment-calendar.rb <VERSION> [start date]\n"
		exit 1
	end

	def version
		return @arguments[0]
	end

	def output_filename
		return "#{@arguments[0].gsub('.', '_')}.md"
	end

	def starting_date
		if @arguments.length > 1
			return Date.parse(@arguments[1]).to_s
		end
		return Date.today.to_s
	end
end	
