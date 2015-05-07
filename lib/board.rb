class Board
  attr_reader :cells, :size
  
  def initialize(size = 3)
    @cells = []
    @size  = size
  end
  
  def add_move(cell)
    @cells << cell
  end

end
