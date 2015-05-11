class Game
  def initialize(board)
    @board = board
  end

  def over?
    winner? || draw?
  end
  
  def winner?
    @board.any_same_player_line?
  end

  def draw?
    !winner? && @board.full?
  end
end
