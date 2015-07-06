require 'pry'

class AiNegamax

  attr_reader :mark

  def initialize(mark, opponent_mark)
    @mark = mark
    @opponent_mark = opponent_mark
  end

  def end_score(result, depth)
    if result == :win
      SCORES[result] - depth
    elsif result == :loss
      SCORES[result] + depth
    else
      SCORES[result]
    end
  end

  def end_result(board)
    winner = board.winner_mark
    if winner == mark
      :win
    elsif winner == opponent_of(mark)
      :loss
    elsif board.full?
      :draw
    end
  end

  def pick_position(board)
    negamax_score(board, mark, 1, 0)
    @best_position
  end

  def negamax_score(current_board, current_mark, point_of_view, depth)
    result = end_result(current_board)
    return point_of_view*end_score(result, depth) if result

    max = -Float::INFINITY

    current_board.available.map do |position|
      next_board = current_board.add_move(position, current_mark)
      score = -negamax_score(next_board, opponent_of(current_mark), -point_of_view, depth+1)
      if score > max
        max = score
        @best_position = position if depth == 0
      end
    end

    max
  end

  private
  attr_reader :opponent_mark

  ScoredPosition = Struct.new(:score, :position)

  SCORES = { draw:  0,
              win:  10,
             loss: -10 }

  def opponent_of(given_mark)
    given_mark == mark ? opponent_mark : mark
  end
end
