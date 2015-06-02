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
    greet
    while !over?
      play_turn
    end
    finish
  end

  def play_turn
    add_to_board(get_position, current_player.mark)
    swap_players
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

  def add_to_board(position, mark)
    board.add_move(position, mark)
  end

  def get_position
    display_board
    valid_position
  end

  def valid_position
    position = current_player.pick_position
    until valid?(position)
      alert
      position = current_player.pick_position
    end
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

  def finish
    display_board
    display_game_over
    display_result
  end

  def display_board
    ui.display_board(board.state_by_rows)
  end

  def display_game_over
    ui.display_game_over
  end

  def display_winner
    ui.display_winner(winner)
  end

  def display_draw
    ui.display_draw
  end

  def winner
    board.winner_mark
  end

  def display_result
    won? ? display_winner : display_draw
  end

  def greet
    ui.greet
  end

  def alert
    ui.alert
  end
end
