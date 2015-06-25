class Board
  def initialize(moves = nil, size = 3)
    @size = size
    @moves = moves || Array.new(size**2)
  end

  def add_move(position, mark)
    moves[position] = mark
  end

  def mark_at(position)
    moves[position]
  end

  def valid?(position)
    available_positions.include?(position)
  end
  
  def available_positions
    moves.each_index.reduce([]) do |available, position|
      available << position unless moves[position]
      available
    end
  end

  def full?
    moves.all? {|move| !move.nil?}
  end

  def winner_line?
    lines.any? do |line|
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
    find_winner_line.first
  end

  def make_next_board(position, mark)
    new_moves = moves.dup
    new_moves[position] = mark
    Board.new(new_moves)
  end

  private
  attr_reader :size, :moves

  def lines
    rows.concat(columns).concat(diagonals)
  end

  def rows
    moves.each_slice(size).to_a
  end

  def columns
    rows.transpose
  end

  def diagonals
    [first_diagonal, second_diagonal]
  end

  def first_diagonal
    rows.each_with_index.reduce([]) do |diagonal, (row, i)|
      diagonal << row[i]
      diagonal
    end
  end

  def second_diagonal
    rows.each_with_index.reduce([]) do |diagonal, (row, i)|
      diagonal << row.reverse[i]
      diagonal
    end
  end

  def full_line?(positions)
    positions
    .all? {|position| !position.nil?}
  end

  def same_mark?(positions)
    positions
    .uniq
    .length == 1
  end

  def find_winner_line
    lines.detect do |line|
      full_line?(line) && same_mark?(line)
    end
  end
end
