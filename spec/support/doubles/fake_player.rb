class FakePlayer

  attr_reader :mark
  
  def initialize(mark, ui)
    @mark = mark
    @ui   = ui
  end
  
  def pick_position
    @ui.get_move_from_user
  end

end
