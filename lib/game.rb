class Game
  def initialize(board, player = nil, ui = nil)
    @board = board
    @player = player
    @ui = ui
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
    position = @player.pick_move(@ui)
    @board.add_move(position, @player.mark)
  end
end
