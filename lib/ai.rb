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
    scores = possible_scores(mark)
    puts "scores: "
    puts scores
    position = scores.max_by { |scored_position| scored_position.score }.position
    puts "position: #{position}"
    position
  end

  def score(current_board, current_mark)
    if end_state?(current_board)
      return score_end_state(current_board)
    end

    scores = possible_boards(current_board, current_mark).map do |possible_board|
      score(possible_board, swap_current_mark(current_mark))
    end

    current_mark == mark ? scores.max : scores.min
  end

  def possible_scores(mark)
    board.available_positions.map do |position|
      possible_board = board.make_copy
      possible_board.add_move(position, mark)
      ScoredPosition.new(position, score(possible_board, swap_current_mark(mark)))
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

  def swap_current_mark(current_mark)
    current_mark == mark ? opponent_mark : mark
  end
end
