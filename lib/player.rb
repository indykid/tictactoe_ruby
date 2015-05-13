class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end
  
  def pick_move(ui)
    ui.capture_position
  end
end
