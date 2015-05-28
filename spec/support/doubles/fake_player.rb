class FakePlayer

  attr_reader :mark
  
  def initialize(mark)
    @mark = mark
  end
  
  def pick_position(ui)
    ui.get_move_from_user
  end

end
