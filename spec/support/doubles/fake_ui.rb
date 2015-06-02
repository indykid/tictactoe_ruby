class FakeUi
  attr_reader :alert_count, :board_display_count, :greet_count, :winner_display_count, :game_over_count, :draw_display_count
  def initialize(inputs = [])
    @inputs        = inputs
    @alert_count   = 0
    @greet_count   = 0
    @game_over_count      = 0
    @board_display_count  = 0
    @winner_display_count = 0
    @draw_display_count   = 0
  end

  def get_move_from_user(player)
    @inputs.shift
  end

  def alert
    @alert_count += 1
  end

  def greet
    @greet_count += 1
  end

  def display_board(board_state)
    @board_display_count += 1
  end

  def display_winner(player)
    @winner_display_count += 1
  end

  def display_game_over
    @game_over_count += 1
  end

  def display_draw
    @draw_display_count += 1
  end
end
