class Board

  def initialize(size = 3)
    @size = size
    @moves = Array.new(size**2)
  end

  def add_move(position, mark)
    moves[position] = mark
  end

  def player_at(position)
    moves[position]
  end

  def available_positions
    moves.each_index.reduce([]) do |available, position|
      available << position unless moves[position]
      available
    end
  end

  def full?
    moves.all? {|move| !!move}
  end

  def any_same_player_line?
    lines.any? do |line|
      full_line?(line) && same_player?(line)
    end
  end

  private
  attr_reader :moves, :size

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
    columns = [[],[],[]]
    #puts Array.new(size, []).to_s
    rows.each do |row|
      row.each_index do |cell_index|
        columns[cell_index] << row[cell_index]
      end
    end
    columns
  end

  def diagonals
    [first_diagonal, second_diagonal]
  end

  def first_diagonal
    diagonal = []
    rows.each_with_index do |row, index|
      diagonal << row[index]
    end
    diagonal
  end

  def second_diagonal
    diagonal = []
    rows.each_with_index do |row, index|
      diagonal << row.reverse[index]
    end
    diagonal
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
end
