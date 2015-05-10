class Board
  attr_reader :cells, :moves, :size

  def initialize(size = 3)
    @cells = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    @moves = []
    @size  = size
  end

  def add_move(position, player)
    @moves << {position: position, player: player}
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

  def full?(line)
    moves = @moves.select{|move| 
      line.include?(move[:position]) 
    }
    moves.length == size && same_player?(moves)
  end

  def winner?
    rows.concat(columns).concat(diagonals).any? do |line|
      full?(line)
    end
  end

  private
  def same_player?(moves)
    moves.map { |m| m[:player] }.uniq.length == 1
  end
end
