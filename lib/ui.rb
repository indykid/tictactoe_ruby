class Ui

  def initialize(input, output)
    @input = input
    @output = output
  end

  GREETING = "Welcome to TicTacToe\nThis game requires two players\nEach player enters move in turn\nFirst player is assigned 'X' mark"
  ALERT    = "INVALID move, please try again"
  MOVE_REQUEST = "Please enter position to play into"

  def greet
    show(GREETING)
  end

  def alert
    show(ALERT)
  end

  def get_move_from_user
    show(MOVE_REQUEST)
    get_numeric_input
  end

  def display(state)
    show(user_friendly(state))
  end

  private
  attr_reader :input, :output

  def get_numeric_input
    move = input.gets
    raise InvalidMoveError if move.to_i.to_s != move
    move
  end

  def show(message)
    output.puts(message)
  end

  def user_friendly(state)
    rows = state.each_slice(3).to_a
    rows.map do |row|
      " " + row.join(" | ") + " "
    end
    .join("\n-----------\n")
  end
end

class InvalidMoveError < StandardError
end
