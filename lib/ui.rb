class Ui

  def initialize(input, output)
    @input = input
    @output = output
  end

  GREETING = "Welcome to TicTacToe\nThis game requires two players\nEach player enters move in turn\nFirst player is assigned 'X' mark"

  def greet
    display(GREETING)
  end

  private
  attr_reader :input, :output

  def display
  end
end
