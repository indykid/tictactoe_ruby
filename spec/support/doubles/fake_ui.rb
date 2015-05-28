class FakeUi
  def initialize(input, output)
    @input = input
    @output = output
  end

  def get_move_from_user
    input.gets.to_i
  end

  def alert
  end

  private
  attr_reader :input
end
