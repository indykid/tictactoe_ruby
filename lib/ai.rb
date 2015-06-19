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
    possible_scored_positions.max_by(&:score).position
  end

  def score(current_board, current_mark)
    return score_end_state(current_board) if end_state?(current_board)

    scores = possible_boards(current_board, current_mark).map do |possible_board|
      score(possible_board, swap_mark(current_mark))
    end

    current_mark == mark ? scores.max : scores.min
  end

  def possible_scored_positions
    board.available_positions.map do |position|
      ScoredPosition.new(
              position, 
              score(make_next_board(position), swap_mark(mark)))
    end
  end

  def possible_boards(board, mark)
    board.available_positions.map do |position|
      possible_board = board.make_copy
      possible_board.add_move(position, mark)
      possible_board
    end
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

  def score_end_state(board)
    if won?(board)
      WIN_SCORE
    elsif drew?(board)
      DRAW_SCORE
    elsif lost?(board)
      LOSE_SCORE
    end
  end

  def make_next_board(position)
    next_board = board.make_copy
    next_board.add_move(position, mark)
    next_board
  end

  def swap_mark(current_mark)
    current_mark == mark ? opponent_mark : mark
  end
end
