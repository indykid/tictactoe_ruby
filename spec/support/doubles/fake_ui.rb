require 'invalid_move_error'

class FakeUi
  def initialize(input, output)
    @input = input
    @output = output
  end

  def get_move_from_user(player)
    input.gets.to_i - 1
  end

  def alert
  end

  def display(board_state)
    show(user_friendly(board_state))
  end

  private
  attr_reader :input

  def show(message)
  end

  def user_friendly(board_state)
  end
end
