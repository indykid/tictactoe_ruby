class AiNegamax
  attr_reader :mark

  def initialize(mark, opponent_mark)
    @mark = mark
    @opponent_mark = opponent_mark
  end

  def pick_position(board)
    negamax_score(board, mark, 1, 1, -INFINITY, INFINITY).position
  end

  def negamax_score(current_board, current_mark, point_of_view, depth, a, b)
    result = end_result(current_board)
    return adjusted_score(result, depth, point_of_view) if result

    best_position = nil

    current_board.available.map do |position|
      score = -negamax_score(
                         current_board.add_move(position, current_mark),
                         opponent_of(current_mark),
                        -point_of_view,
                         depth + 1,
                        -b,
                        -a).score

      return ScoredPosition.new(a, position) if a >= b

      if score > a
        a = score
        best_position = position
      end
    end

    ScoredPosition.new(a, best_position)
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

  private
  attr_reader :opponent_mark

  ScoredPosition = Struct.new(:score, :position)
  SCORES = { draw:  0,
              win:  10,
             loss: -10 }
  INFINITY = Float::INFINITY

  def opponent_of(given_mark)
    given_mark == mark ? opponent_mark : mark
  end

  def end_score(result)
    SCORES[result]
  end

  def adjusted_score(result, depth, point_of_view)
    score = end_score(result)
    ScoredPosition.new(point_of_view*score/depth) if score
  end
end
