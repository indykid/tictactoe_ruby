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

  private
  attr_reader :opponent_mark

  SCORES = { draw:  0,
              win:  10,
             loss: -10 }
end
