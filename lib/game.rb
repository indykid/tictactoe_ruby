class Game
  def initialize(board, player = nil)
    @board = board
    @player = player
  end

  def over?
    @board.winner? ||  @board.draw?
  end
  
  def play!
    while !over?
      @board = @player.play_turn(@board)
    end
  end
end
