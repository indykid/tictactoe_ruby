class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end
  
  def move(ui)
    ui.capture_position
  end
end
