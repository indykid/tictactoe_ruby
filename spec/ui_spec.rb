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
    input = StringIO.new("a")
    ui = Ui.new(input, output)

    expect { ui.get_move_from_user }.to raise_error(InvalidMoveError)
  end

  it 'shows the board' do
    board = Board.new
    ui.display(board.state_by_rows)

    expect(output.string).to eq(
      " 0 | 1 | 2 \n-----------\n 3 | 4 | 5 \n-----------\n 6 | 7 | 8 \n"
    )
  end
end
