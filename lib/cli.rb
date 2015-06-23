class Cli

  attr_reader :output

  def initialize(input, output)
    @input = input
    @output = output
  end

  def show(message)
    output.puts("\n" + message)
  end

  def get_input
    input.gets
  end

  def get_clean_input
    get_input.chomp
  end

  private
  attr_reader :input
end
