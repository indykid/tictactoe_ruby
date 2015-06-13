class Ai
  attr_reader :mark
  def initialize(mark)
    @mark = mark
  end

  WIN_SCORE  = 10
  LOSE_SCORE = -10
  DRAW_SCORE = 0

  def pick_position
  
  end

  def score(board)
    score_end_state(board)
  end
  
  def find_children(board, mark)
    board.available_positions.reduce([]) do |boards, position|
      board_copy = board.make_copy
      board_copy.add_move(position, mark)
      boards << board_copy
      boards
    end
  end

  private

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
    else
      LOSE_SCORE
    end
  end
end
