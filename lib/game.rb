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
    begin
      position = get_position
    rescue InvalidMoveError
      ui.alert
      play_turn
    else
      board.add_move(position, current_player.mark)
      swap_players
    end
  end

  private

  attr_reader :board, :player_x, :player_o, :ui, :current_player

  def won?
    board.same_player_line?
  end

  def drawn?
    no_moves_left? && !won?
  end

  def no_moves_left?
    board.full?
  end

  def get_position
    ui.display(board.state_by_rows)
    position = current_player.pick_position
    raise InvalidMoveError if !valid?(position)
    position
  end

  def valid?(position)
    board.valid?(position)
  end

  def swap_players
    @current_player = reset_current_player
  end

  def reset_current_player
    @current_player == player_x ? player_o : player_x
  end
end
