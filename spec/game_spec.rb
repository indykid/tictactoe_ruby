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

  it 'gets moves from player' do
    player = Puppet.new(:x, [0,1,2])
    board = Board.new
    game = Game.new(board, player)

    game.play!
    expect(game.over?).to be true
  end

  class Puppet
    def initialize(mark, moves)
      @mark = mark
      @moves = moves
    end

    def play_turn(board)
      board.add_move(@moves.unshift, @mark)
      board
    end

  end
end
