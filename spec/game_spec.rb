require 'game'
describe Game do
  it 'is over when there is a winner' do
    board = Board.new
    board.add_move(0, 'x')
    board.add_move(1, 'x')
    board.add_move(2, 'x')
    game = Game.new(board)
    expect(game.over?).to be(true)
  end

  it 'is over when drawn' do
    board = Board.new
    board.add_move(0, 'x')
    board.add_move(1, 'o')
    board.add_move(2, 'x')
    board.add_move(3, 'o')
    board.add_move(4, 'o')
    board.add_move(5, 'x')
    board.add_move(6, 'x')
    board.add_move(7, 'x')
    board.add_move(8, 'o')
    game = Game.new(board)
    expect(game.over?).to be(true)
  end

  it 'gets move from player' do
    board = Board.new
    player = FakePlayer.new(:x, [0])
    game = Game.new(board, player)
    game.play
    puts board.moves
    expect(board.taken?(0)).to be(true)
  end

end

class FakePlayer
  attr_reader :plays
  def initialize(mark, plays = [])
    @mark = mark
    @plays = plays
  end

  def move(board, position)
    board.add_move(position, @mark)
  end
end
