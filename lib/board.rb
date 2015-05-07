class Board
  attr_reader :cells, :moves, :size
  
  def initialize(size = 3)
    @cells = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    @moves = []
    @size  = size
  end
  
  def add_move(cell)
    @moves << cell
  end

  def taken?(cell)
    @moves.include?(cell)
  end

  def rows
    @cells.each_slice(size)
  end
end
