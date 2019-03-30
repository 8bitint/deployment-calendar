#!/usr/bin/env ruby 
Dir[File.join(".", "lib/*.rb")].each do |f|
  require f
end

def fail_on_missing(filename) 
	if !File.exist? filename
		print "missing file: #{filename}\n"
		exit 1
	end
end

def fail_on_incorrect_options(options)
	if (!options.args_correct) 
		options.print_usage
		exit 1
	end
end

TEMPLATE_FILE = "cfg/deployment-template.md"
CONFIG_FILE   = "cfg/template.cfg"
fail_on_missing(TEMPLATE_FILE)
fail_on_missing(CONFIG_FILE)

options = Options.new(ARGV)
fail_on_incorrect_options(options)
puts "Starting date is: #{options.starting_date}\n"

config = eval(File.open(CONFIG_FILE) {|f| f.read })
outputFile = File.new(options.output_filename, "w")

dayToDateMapper = DayToDateMapper.new(options.starting_date)
templateTransformer = TemplateTransformer.new(config, dayToDateMapper)
IO.foreach(TEMPLATE_FILE) do |line| 
	outputFile.puts(templateTransformer.convert(line))
end
