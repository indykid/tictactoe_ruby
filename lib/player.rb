class Player
  def initialize(mark)
    @mark = mark
  end
  
  def move(board, position)
    board.add_move(position, @mark)
  end
end
