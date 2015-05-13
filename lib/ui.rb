class Ui
  attr_reader :output, :input

  def initialize(output, input)
    @output = output
    @input  = input
  end

  def show(message)
    @output.puts(message)
  end

  def ask_for_position
    show('enter next move')
  end

  def take_input
    @input.gets.chomp
  end

  def capture_position
    ask_for_position
    take_input.to_i
  end
end
