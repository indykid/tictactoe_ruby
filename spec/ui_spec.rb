require 'ui'

describe Ui do
  it 'asks user for the position' do
    ui = Ui.new(StringIO.new, StringIO.new)
    ui.ask_for_position
    expect(ui.output.string).to eq("enter next move\n")
  end

  it 'receives input from user' do
    ui = Ui.new(StringIO.new, StringIO.new('0'))
    ui.take_input
    expect(ui.input.string).to eq('0')
  end

  it 'converts received position input into an integer' do
    ui = Ui.new(StringIO.new, StringIO.new('0'))
    expect(ui.capture_position).to eq(0)
  end
end
