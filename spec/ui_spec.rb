require 'ui'
require 'board'

describe Ui do

  let(:output) { StringIO.new }
  let(:input) { StringIO.new } 
  let(:ui) { Ui.new(input, output) }

  it 'greets' do
    ui.greet

    expect(output.string).to include(Ui::GREETING)
  end

  it 'alerts' do
    ui.alert

    expect(output.string).to include(Ui::ALERT)
  end

  it 'asks user for input' do
    input = StringIO.new("0")
    ui = Ui.new(input, output)

    ui.get_move_from_user(:x)

    expect(output.string).to include(Ui::MOVE_REQUEST)
  end

  it 'gets input for move from user' do
    input = StringIO.new("0")
    ui = Ui.new(input, output)

    ui.get_move_from_user(:x)

    expect(input.string).to eq('0')
  end

  it 'shows user friendly board' do
    ui.display([[:x, 1, 2], [3, 4, 5], [6, 7, 8]])

    expect(output.string).to eq(
      "\n x | 2 | 3 \n-----------\n 4 | 5 | 6 \n-----------\n 7 | 8 | 9 \n"
    )
  end
end
