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

  def columns
    columns = []
    (0...size).each do |i|
      column = []
      rows.each do |row|
        column << row[i]
      end
      columns << column
    end
    columns
  end

  def diagonals
    [first_diagonal, second_diagonal]
  end

  def first_diagonal
    diagonal = []
    i = size + 1
    cell = @cells.first
    size.times do
      diagonal << cell
      cell += i
    end
    diagonal
  end

  def second_diagonal
    diagonal = []
    i = size - 1
    cell = @cells[i]
    size.times do
      diagonal << cell
      cell += i
    end
    diagonal
  end







end
