require 'game'
require 'helpers'

describe Game do

  let(:board) { Board.new }
  let(:player_x) { Player.new(:x) }
  let(:player_o) { Player.new(:o) }
  let(:output) { StringIO.new }

  it 'is over when there is a winner' do
    game = setup_game
    add_multiple_moves(:x, [0, 1, 2], board)
    expect(game.over?).to be(true)
  end

  it 'is over when drawn' do
    game = setup_game
    fill_the_board(board)
    expect(game.over?).to be(true)
  end

  it 'places move from player on the board' do
    game = setup_game([0])
    game.play_turn
    expect(board.taken?(0)).to be(true)
  end

  it 'gets Ui to visualise board' do
    game = setup_game([0])
    game.play_turn
    expect(output.string).to start_with("0 1 2\n3 4 5\n6 7 8\n")
  end

  it 'only plays valid moves' do
    game = setup_game([0, 0])

    game.play_turn
    game.play_turn

    expect(board.moves.length).to eq(1)
  end

  it 'tracks player turns' do
    game = setup_game([0, 1])

    game.play_turn
    game.play_turn

    expect(board.moves.first[:mark]).to eq(:x)
    expect(board.moves.last[:mark]).to eq(:o)
  end

  it "doesn't ask for moves if won" do

  end

  def setup_game(inputs = [])
    ui = FakeUi.new(inputs, output)
    Game.new(board, player_x, player_o, ui)
  end

end

class FakeUi
  def initialize(inputs, output)
    @input = setup_input(inputs)
    @output = output
  end

  def setup_input(inputs)
    StringIO.new(inputs.join("\n"))
  end

  def visualise(board)
    @output.puts(output_friendly(board)) 
  end

  def output_friendly(board)
    split_into_lines(board).map do |line|
      line.join(' ')
    end
  end

  def split_into_lines(board)
    board.state.each_slice(board.size)
  end

  def ask_for_position
    @output.puts('enter next move')
  end

  def take_input
    @input.gets.chomp
  end

  def capture_position
    ask_for_position
    take_input.to_i
  end
end
