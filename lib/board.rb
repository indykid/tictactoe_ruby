class Board
  def initialize(moves = nil, size = 3)
    @size = size
    @moves = moves || Array.new(size**2)
  end

  def add_move(position, mark)
    moves[position] = mark
  end

  def player_at(position)
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

  def same_player_line?
    lines.any? do |line|
      full_line?(line) && same_player?(line)
    end
  end

  def state_by_rows
    moves.map.with_index do |move, i|
      move || i
    end
    .each_slice(size).to_a
  end

  def winner_mark
    moves[position_on_the_same_player_line]
  end

  def make_copy
    new_moves = moves.dup
    Board.new(new_moves)
  end

  private
  attr_reader :size, :moves

  def positions
    [*0...size**2]
  end

  def lines
    rows.concat(columns).concat(diagonals)
  end

  def rows
    positions.each_slice(size).to_a
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
    moves_for(positions)
    .all? {|move| !move.nil?}
  end

  def same_player?(positions)
    moves_for(positions)
    .uniq
    .length == 1
  end

  def moves_for(positions)
    positions.map do |position|
      moves[position]
    end
  end

  def find_same_player_line
    lines.detect do |line|
      full_line?(line) && same_player?(line)
    end
  end

  def position_on_the_same_player_line
    find_same_player_line.first
  end
end
