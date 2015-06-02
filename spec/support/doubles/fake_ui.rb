require 'invalid_move_error'

class FakeUi
  def initialize(inputs)
    @inputs        = inputs
    @alert_count   = 0
    @display_count = 0
  end

  def get_move_from_user(player)
    @inputs.shift
  end

  def alert
    @alert_count += 1
  end

  def display(board_state)
    @display_count += 1
  end
end
