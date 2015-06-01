require 'ui'
require 'board'

describe Ui do

  let(:output) { StringIO.new }
  let(:input) { StringIO.new } 
  let(:ui) { Ui.new(input, output) }

  it 'greets' do
    ui.greet

    expect(output.string).to start_with(Ui::GREETING)
  end

  it 'alerts' do
    ui.alert

    expect(output.string).to start_with(Ui::ALERT)
  end

  it 'asks user for input' do
    input = StringIO.new("0")
    ui = Ui.new(input, output)

    ui.get_move_from_user

    expect(output.string).to start_with(Ui::MOVE_REQUEST)
  end

  it 'gets input for move from user' do
    input = StringIO.new("0")
    ui = Ui.new(input, output)

    ui.get_move_from_user

    expect(input.string).to eq('0')
  end

  it 'errors if non-numeric input' do
    input = StringIO.new("a\n")
    ui = Ui.new(input, output)

    expect { ui.get_move_from_user }.to raise_error(InvalidMoveError)
  end

  it 'does not error if numeric input' do
    input = StringIO.new("0\n")
    ui = Ui.new(input, output)

    expect{ui.get_move_from_user}.not_to raise_error
  end

  it 'shows user friendly board' do
    ui.display([[0, 1, 2], [3, 4, 5], [6, 7, 8]])

    expect(output.string).to eq(
      " 0 | 1 | 2 \n-----------\n 3 | 4 | 5 \n-----------\n 6 | 7 | 8 \n"
    )
  end
end
