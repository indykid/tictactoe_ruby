class Player
  attr_reader :mark

  def initialize(mark, ui)
    @mark = mark
    @ui   = ui
  end
  
  def pick_position
    ui.get_move_from_user(mark)
  end

  private
  attr_reader :ui
end
