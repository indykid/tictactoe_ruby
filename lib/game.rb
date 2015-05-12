class Game
  def initialize(board, player = nil)
    @board = board
    @player = player
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

  def play_turn
  end
end
