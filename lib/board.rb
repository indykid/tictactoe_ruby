class Board
  attr_reader :available
  def initialize(moves = nil, size = 3)
    @size = size
    @moves = moves || Array.new(size**2)
    @available = available_positions
  end

  def add_move(position, mark)
    moves[position] = mark
    @available.delete(position)
  end

  def mark_at(position)
    moves[position]
  end

  def valid?(position)
    @available.include?(position)
  end

  def full?
    moves.count(nil) == 0
  end

  def winner_line
    lines.find do |line|
      full_line?(line) && same_mark?(line)
    end
  end

  def state_by_rows
    moves.map.with_index do |move, i|
      move || i
    end
    .each_slice(size).to_a
  end

  def winner_mark
    winner_line.first
  end

  def make_next_board(position, mark)
    new_moves = moves.dup
    new_moves[position] = mark
    Board.new(new_moves)
  end

  private
  attr_reader :size, :moves
  
  def available_positions
    moves.each_index.reduce([]) do |available, position|
      available << position unless moves[position]
      available
    end
  end

  def line_positions
    @line_positions ||= diagonal_positions.concat(row_positions).concat(column_positions)

  end

  def row_positions
    moves.each_index.each_slice(size).to_a
  end

  def column_positions
    row_positions.transpose
  end

  def diagonal_positions
    [first_diagonal_positions, second_diagonal_positions]
  end

  def first_diagonal_positions
    row_positions.each_with_index.reduce([]) do |diagonal, (row, i)|
      diagonal << row[i]
      diagonal
    end
  end

  def second_diagonal_positions
    row_positions.each_with_index.reduce([]) do |diagonal, (row, i)|
      diagonal << row.reverse[i]
      diagonal
    end
  end

  def lines
    line_positions.map do |line|
      line.map do |position|
        moves[position]
      end
    end
  end

  def full_line?(marks)
    marks.count(nil) == 0
  end

  def same_mark?(marks)
    marks.count(marks.first) == size
  #  marks
  #  .uniq
  #  .length == 1
  end
end
