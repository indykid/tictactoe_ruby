class Ai
  attr_reader :mark
  def initialize(mark, board)
    @mark = mark
    @board = board
    @opponent_mark = set_opponent_mark
  end

  WIN_SCORE  = 10
  LOSE_SCORE = -10
  DRAW_SCORE = 0

  ScoredPosition = Struct.new(:position, :score)

  def pick_position
    board.available_positions.map do |position|
      ScoredPosition.new(
        position, 
        score(make_next_board(position), swap_mark(mark), 0))
    end
    .max_by(&:score).position
  end

  def score(current_board, current_mark, depth)
    return score_end_state(current_board, depth) if end_state?(current_board)
    depth += 1

    scores = current_board.available_positions.map do |position|
      score(current_board.make_next_board(position, current_mark),
            swap_mark(current_mark),
            depth)
    end

    current_mark == mark ? scores.max : scores.min
  end

  private

  attr_reader :board, :opponent_mark

  def set_opponent_mark
    mark == :x ? :o : :x
  end

  def end_state?(board)
    won?(board) || drew?(board) || lost?(board)
  end

  def won?(board)
    board.same_player_line? && board.winner_mark == mark
  end

  def drew?(board)
    board.full? && !board.same_player_line?
  end

  def lost?(board)
    board.same_player_line? && board.winner_mark != mark
  end

  def score_end_state(board, depth)
    if won?(board)
      WIN_SCORE - depth
    elsif drew?(board)
      DRAW_SCORE
    elsif lost?(board)
      LOSE_SCORE + depth
    end
  end

  def make_next_board(position)
    board.make_next_board(position, mark)
  end

  def swap_mark(current_mark)
    current_mark == mark ? opponent_mark : mark
  end
end
