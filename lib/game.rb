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
    @ui.visualise(@board)
    position = @player.pick_move(@ui)
    if valid_move?(position)
      @board.add_move(position, @player.mark)
    end
  end

  def valid_move?(position)
    !@board.taken?(position)
  end
end
