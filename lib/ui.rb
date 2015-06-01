require 'invalid_move_error'

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

  def display(board_state)
    show(draw(board_state))
  end

  private
  attr_reader :input, :output

  def get_numeric_input
    move_input = input.gets.chomp
    convert_to_number(move_input)
  end

  def show(message)
    output.puts(message)
  end

  def draw(board_state)
    board_state.map do |row|
      " " + row.join(" | ") + " "
    end
    .join("\n-----------\n") + "\n"
  end

  def convert_to_number(move_input)
    move = move_input.to_i
    validate_number(move, move_input)
  end

  def validate_number(move, move_input)
    raise InvalidMoveError if move.to_s != move_input
    move
  end
end
