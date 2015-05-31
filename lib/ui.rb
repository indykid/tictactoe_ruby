class Ui

  def initialize(input, output)
    @input = input
    @output = output
  end

  GREETING = "Welcome to TicTacToe\nThis game requires two players\nEach player enters move in turn\nFirst player is assigned 'X' mark"
  ALERT    = "INVALID move, please try again"
  MOVE_REQUEST = "Please enter position to play into"

  def greet
    display(GREETING)
  end

  def alert
    display(ALERT)
  end

  def get_move_from_user
    display(MOVE_REQUEST)
    input.gets
  end

  private
  attr_reader :input, :output

  def display(message)
    output.puts(message)
  end
end
