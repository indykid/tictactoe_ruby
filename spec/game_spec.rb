require 'game'
require 'helpers'

describe Game do

  let(:board) { Board.new }

  it 'is over when there is a winner' do
    game = Game.new(board)
    add_multiple_moves(:x, [0, 1, 2], board)
    expect(game.over?).to be(true)
  end

  it 'is over when drawn' do
    game = Game.new(board)
    fill_the_board(board)
    expect(game.over?).to be(true)
  end

  it 'places move from player on the board' do
    player = Player.new(:x)
    ui = Ui.new(StringIO.new, StringIO.new('0'))
    game = Game.new(board, player, ui)

    game.play_turn

    expect(board.taken?(0)).to be(true)
  end

  it 'gets Ui to visualise board' do
    player = Player.new(:x)
    ui = Ui.new(StringIO.new, StringIO.new('0'))
    game = Game.new(board, player, ui)

    game.play_turn

    expect(ui.output.string).to start_with("0 1 2\n3 4 5\n6 7 8\n")
  end

  it 'only plays valid moves' do
    player = Player.new(:x)
    ui = Ui.new(StringIO.new, StringIO.new("0\n0"))
    game = Game.new(board, player, ui)

    game.play_turn
    game.play_turn

    expect(board.moves.length).to eq(1)
  end
end
