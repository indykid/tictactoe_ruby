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
    if board.same_player_line? && board.winner_mark == mark
      WIN_SCORE
    elsif board.full? && !board.same_player_line?
      DRAW_SCORE
    else
      LOSE_SCORE
    end
  end
  
  def find_children(board, mark)
    board.available_positions.reduce([]) do |boards, position|
      board_copy = board.make_copy
      board_copy.add_move(position, mark)
      puts board_copy.inspect
      boards << board_copy
      boards
    end
  end
end
