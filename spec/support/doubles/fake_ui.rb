require 'invalid_move_error'

class FakeUi
  def initialize(input, output)
    @input = input
    @output = output
  end

  def get_move_from_user
    move = input.gets.chomp
    raise InvalidMoveError if move.to_i.to_s != move
    move.to_i
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
