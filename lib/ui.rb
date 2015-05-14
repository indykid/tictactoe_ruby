class Ui
  attr_reader :output, :input

  PROMPT = "Enter next move"
  ALERT = "INVALID MOVE, please try again"

  def initialize(output, input)
    @output = output
    @input  = input
  end

  def show(message)
    @output.puts(message)
  end

  def ask_for_position
    show(PROMPT)
  end

  def take_input
    @input.gets.chomp
  end

  def capture_position
    ask_for_position
    take_input.to_i
  end

  def visualise(board)
    show(line_break)
    show(output_friendly(board)) 
  end

  def output_friendly(board)
    split_into_lines(board).map do |line|
      line.join(' ')
    end
  end

  def split_into_lines(board)
    board.state.each_slice(board.size)
  end

  def line_break
    "\n"
  end
end
