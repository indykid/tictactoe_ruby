class Board
  attr_reader :cells, :moves, :size

  def initialize(size = 3)
    @cells = generate_cells(size)
    @moves = []
    @size  = size
  end

  def add_move(position, mark)
    @moves << {position: position, mark: mark}
  end

  def taken?(position)
    @moves.any? { |m| m[:position] == position }
  end

  def rows
    @cells.each_slice(size).to_a
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

  def taken_by_same_player?(line)
    line_moves = taken_moves_on(line)
    full_line?(line_moves) && same_player?(line_moves)
  end

  def any_same_player_line?
    lines.any? do |line|
      taken_by_same_player?(line)
    end
  end

  def full?
    @moves.length == @cells.length
  end

  private
 
  def generate_cells(size)
    [*0...size**2]
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

  def lines
    rows.concat(columns).concat(diagonals)
  end

  def same_player?(moves)
    moves.map { |m| m[:mark] }.uniq.length == 1
  end

  def taken_moves_on(line)
    @moves.select{|move| 
      line.include?(move[:position]) 
    }
  end

  def full_line?(moves)
    moves.length == size
  end
end
