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

  def pick_position
    score(board, mark)
    next_position
  end

  def score(board, current_mark)
    scores = []
    positions = []

    if end_state?(board)
      board_score = score_end_state(board)
    else
      board.available_positions.each do |position|
        possible_board = board.make_copy
        possible_board.add_move(position, current_mark)

        scores << score(possible_board, swap_current_mark(current_mark))
        positions << position 
      end

      if current_mark == mark
        board_score = scores.max
        max_score_index = scores.each_with_index.max[1]
        self.next_position = positions[max_score_index]
      elsif current_mark == opponent_mark
        board_score = scores.min
        min_score_index = scores.each_with_index.min[1]
        self.next_position = positions[min_score_index]
      end

    end
    board_score
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

  attr_reader :board, :opponent_mark
  attr_accessor :next_position

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
