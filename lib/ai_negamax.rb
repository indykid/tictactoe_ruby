class AiNegamax

  attr_reader :mark

  def initialize(mark, opponent_mark)
    @mark = mark
    @opponent_mark = opponent_mark
  end

  def final_score(result)
    case result
    when :win
      10
    when :loss
      -10
    when :draw
      0
    end
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
end
