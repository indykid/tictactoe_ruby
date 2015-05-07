class Board
  attr_reader :moves, :size
  
  def initialize(size = 3)
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
    @moves.each_slice(size)
  end
end
