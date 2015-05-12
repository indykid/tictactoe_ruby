class Player
  def initialize(mark)
    @mark = mark
  end
  
  def move(ui)
    ui.ask_for_move
  end
end

