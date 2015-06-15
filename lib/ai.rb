class Ai
  attr_reader :mark
  def initialize(mark)
    @mark = mark
    @opponent_mark = set_opponent_mark
  end

  WIN_SCORE  = 10
  LOSE_SCORE = -10
  DRAW_SCORE = 0

  def pick_position
  end

  def score(board, current_mark)
    if end_state?(board)
      score_end_state(board)
    else
      scores = possible_boards(board, current_mark).map do |child|
        score(child, swap_current_mark(current_mark))
      end
      
      current_mark == mark ? scores.max : scores.min
    end
  end

  def possible_boards(board, mark)
    board.available_positions.reduce([]) do |boards, position|
      board_copy = board.make_copy
      board_copy.add_move(position, mark)
      boards << board_copy
      boards
    end
  end

  private

  attr_reader :opponent_mark

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

  def swap_current_mark(current_mark)
    current_mark == mark ? opponent_mark : mark
  end
end
