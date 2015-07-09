class Board
  attr_reader :available
  def initialize(moves = nil, size = 3)
    @size = size
    @moves = moves || Array.new(size**2)
    @available = available_positions
    @win_positions = rows.concat(columns).concat(diagonals)
  end

  def add_move(position, mark)
    new_moves = moves.dup
    new_moves[position] = mark
    Board.new(new_moves, size)
  end

  def mark_at(position)
    moves[position]
  end

  def valid?(position)
    available.include?(position)
  end

  def full?
    moves.count(nil) == 0
  end

  def winner_line
    win_positions.find do |line|
      winner?(line) && occupied?(line[0])
    end
  end

  def winner?(line)
    moves[line[0]] == moves[line[1]] && moves[line[2]] == moves[line[1]]
  end

  def occupied?(position)
    moves[position] != nil
  end

  def state_by_rows
    moves.map.with_index do |move, i|
      move || i
    end
    .each_slice(size).to_a
  end

  def winner_mark
    line = winner_line
    moves[line.first] if line
  end

  def ==(board)
    self.moves == board.moves
  end

  private
  attr_reader :size, :win_positions

  def available_positions
    moves.each_index.reduce([]) do |available, position|
      available << position unless moves[position]
      available
    end
  end

  def get_marks(positions)
    positions.map { |position| moves[position] }
  end

  def update_moves(position, mark)
    moves[position] = mark
  end

  def update_available(position)
    available.delete(position)
  end

  def full_line?(marks)
    marks.each do |mark|
      return false if mark.nil?
    end
    true
  end

  def same_mark?(marks)
    marks.count(marks.first) == size
  end

  def lines
    rows.concat(columns).concat(diagonals)
  end

  def rows
    @rows ||= moves.each_index.each_slice(size).to_a
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

  protected
  attr_reader :moves
end
