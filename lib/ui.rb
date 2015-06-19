module Ui
  def show(message)
    output.puts("\n" + message)
  end

  def get_input
    input.gets
  end

  def get_clean_input
    get_input.chomp
  end
end
