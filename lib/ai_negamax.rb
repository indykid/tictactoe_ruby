class AiNegamax

  attr_reader :mark

  def initialize(mark, opponent_mark)
    @mark = mark
    @opponent_mark = opponent_mark
  end

  def end_score(result)
    SCORES[result]
  end

  def end_result(board)
    winner = board.winner_mark
    if winner == mark
      :win
    elsif winner == opponent_mark
      :loss
    elsif board.full?
      :draw
    end
  end

  def negamax_score(current_board, current_mark, multiplier)
    result = end_result(current_board)
    return end_score(result) if result

    max = current_board.available.map do |position|
      next_board = current_board.add_move(position, current_mark)
      score = negamax_score(next_board, opponent_of(current_mark), multiplier*(-1))
   
      ScoredPosition.new(score, position)
    end.max_by(&:score)

    max.score
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
