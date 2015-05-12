require 'game'
require 'helpers'

describe Game do

  let(:board) { Board.new }

  it 'is over when there is a winner' do
    add_multiple_moves(:x, [0, 1, 2], board)
    game = Game.new(board)
    expect(game.over?).to be(true)
  end

  it 'is over when drawn' do
    fill_the_board(board)
    game = Game.new(board)
    expect(game.over?).to be(true)
  end

  xit 'gets move from player' do
    player = FakePlayer.new(:x, [0])
    game = Game.new(board, player)
    game.play_turn
    expect(board.taken?(0)).to be(true)
  end
end



