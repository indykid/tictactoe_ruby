class Game
  def initialize(board)
    @board = board
  end

  def over?
    @board.winner?
  end
end
