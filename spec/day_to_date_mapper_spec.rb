require 'day_to_date_mapper.rb'

STARTING_DATE = "1-Mar-2019"

RSpec.describe DayToDateMapper do
  converter = DayToDateMapper.new(STARTING_DATE)

  it "returns the date of next Monday" do  
    expect(converter.date_of_next("Monday")).to eq(Date.parse("4-Mar-2019"))
  end

  it "returns the date of next Tuesday" do  
    expect(converter.date_of_next("tuesday")).to eq(Date.parse("5-Mar-2019"))
  end

  it "returns the date of next Wednesday" do  
    expect(converter.date_of_next("WED")).to eq(Date.parse("6-Mar-2019"))
  end

  it "returns the date of next Thursday" do  
    expect(converter.date_of_next("thurs")).to eq(Date.parse("7-Mar-2019"))
  end

  it "returns the date of next Friday" do  
    expect(converter.date_of_next("FRIDAY")).to eq(Date.parse("1-Mar-2019"))
  end

  it "returns the date of next Saturday" do  
    expect(converter.date_of_next("saturday")).to eq(Date.parse("2-Mar-2019"))
  end

  it "returns the date of next Sunday" do  
    expect(converter.date_of_next("Sunday")).to eq(Date.parse("3-Mar-2019"))
  end

  it "ignores the starting date when returning today's date" do
    allow(Date).to receive(:today).and_return(Date.parse("1-Mar-2030"))
    expect(converter.date_of_next("today")).to eq(Date.parse("1-Mar-2030"))
  end

  it "ignores the starting date when returning tomorrow's date" do
    allow(Date).to receive(:today).and_return(Date.parse("1-Mar-2030"))
    expect(converter.date_of_next("tomorrow")).to eq(Date.parse("2-Mar-2030"))
  end

  it "raises an error when the day of the week is unknown" do
    expect{
        converter.date_of_next("heat death of the universe")
      }.to raise_error('I only understand English Gregorian days of the week')
  end
end
