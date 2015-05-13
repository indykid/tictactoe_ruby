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
end
