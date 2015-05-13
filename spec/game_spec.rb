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
    game = setup_game('0')

    game.play_turn

    expect(board.taken?(0)).to be(true)
  end

  it 'gets Ui to visualise board' do
    game = setup_game("0")

    game.play_turn

    expect(output.string).to start_with("0 1 2\n3 4 5\n6 7 8\n")
  end

  it 'only plays valid moves' do
    game = setup_game("0\n0")

    game.play_turn
    game.play_turn

    expect(board.moves.length).to eq(1)
  end

  it 'keeps track of turns' do
    game = setup_game("0\n1")

    game.play_turn
    game.play_turn

    expect(board.moves.first[:mark]).to eq(:x)
    expect(board.moves.last[:mark]).to eq(:o)
  end

  def setup_game(input_string = '')
    ui = Ui.new(output, StringIO.new(input_string))
    game = Game.new(board, player_x, player_o, ui)
  end
end
