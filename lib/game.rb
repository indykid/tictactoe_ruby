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

  def play_turn
    position = current_player.pick_position(ui)
    if valid?(position)
      board.add_move(position, current_player.mark)
      reset_current_player
    else
      play_turn
    end
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
    board.available_positions.include?(position)
  end

  def reset_current_player
    @current_player = swap_players
  end

  def swap_players
    current_player == player_x ? player_o : player_x
  end
end

class InvalidMoveError < StandardError
end
