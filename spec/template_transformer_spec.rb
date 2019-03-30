require 'template_transformer.rb'

RSpec.describe TemplateTransformer do

  CONFIG = {
      :columnSeparator => '|',
      :dateColumn => 2,
      :dateColumnWidth => 10,
      :dateTimeFormat => '%d-%b'
  }

  before(:each) do
    @dayToDateMapper = double("DayToDateMapper")
    @transformer = TemplateTransformer.new(CONFIG, @dayToDateMapper)
  end

  it "will not fail on header or footer lines" do
    expect(@dayToDateMapper).to receive(:date_of_next).with(nil).and_raise(RuntimeError)

    line = @transformer.convert("a header line without field separators\n")
    expect(line).to eq("a header line without field separators\n")
  end  

  it "will not fail on empty lines" do
    expect(@dayToDateMapper).to receive(:date_of_next).with(nil).and_raise(RuntimeError)

    line = @transformer.convert("\n")
    expect(line).to eq("\n")
  end  

  it "will not transform unknown days of the week" do
    expect(@dayToDateMapper).to receive(:date_of_next).with("wotday").and_raise(RuntimeError)

    line = @transformer.convert("|ignore|wotday|something|something|\n")
    expect(line).to eq("|ignore|wotday|something|something|\n")
  end

  it "will convert days of the week fields using the defined format and center them" do
    expect(@dayToDateMapper).to receive(:date_of_next).with("Monday").and_return(Date.parse("2019-11-1"))

    line = @transformer.convert("|ignore|Monday|something|\n")
    expect(line).to eq("|ignore|  01-Nov  |something|\n")
  end
end
