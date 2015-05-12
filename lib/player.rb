class Player
  def initialize(mark)
    @mark = mark
  end
  
  def move(ui)
    ui.ask_for_move
  end
end

class Ui
  def initialize(input)
    @input = input
  end

  def ask_for_move
    @input.gets.chomp.to_i
  end
end
