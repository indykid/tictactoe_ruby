class Game

  def initialize(board, ui, player_x, player_o)
    @board  = board
    @ui     = ui 
    @player_x = player_x
    @player_o = player_o
    @current_player = player_x
  end

  def over?
    won? || drawn?
  end

  def play
    while !over?
      play_turn
    end
  end

  def play_turn
    # simplify this loop?
    position = nil
    loop do
      position = current_player.pick_position(ui)
      break if valid?(position)
    end
    board.add_move(position, current_player.mark)
    reset_current_player
  end

  private

  attr_reader :board, :player_x, :player_o, :ui, :current_player

  def won?
    board.any_same_player_line?
  end

  def drawn?
    no_moves_left? && !won?
  end

  def no_moves_left?
    board.full?
  end

  def valid?(position)
    board.valid?(position)
  end

  def reset_current_player
    @current_player = swap_players
  end

  def swap_players
    @current_player == player_x ? player_o : player_x
  end
end
