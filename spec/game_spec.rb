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
end
