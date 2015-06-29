require 'ruby-prof'
require 'benchmark'

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

    scored_position = ''
    result = RubyProf.profile do
      max = -Float::INFINITY
      board.available.each do |position|
        score = score(make_next_board(position), swap_mark(mark), 0)
        if score > max
          max = score
          scored_position = ScoredPosition.new(position, score)
        end
      end
    end

    File.open("./prof_graph.txt", "w") do |file|
      RubyProf::GraphPrinter.new(result).print(file)
    end
    File.open("./prof_graph.html", "w") do |file|
      RubyProf::GraphHtmlPrinter.new(result).print(file)
    end
    scored_position.position
  end

  def score(current_board, current_mark, depth)
    return score_end_state(current_board, depth) if end_state?(current_board)
    depth += 1

    scores = current_board.available.map do |position|
      score(current_board.make_next_board(position, current_mark),
            swap_mark(current_mark),
            depth)
    end

    current_mark == mark ? scores.max : scores.min
  end

  private

  attr_reader :board, :opponent_mark

  def set_opponent_mark
    mark == :x ? :o : :x
  end

  def end_state?(board)
    won?(board) || full?(board)
  end

  def won?(board)
    board.winner_line
  end

  def full?(board)
    board.full?
  end

  def score_end_state(board, depth)
    if won?(board)
      score_win_or_loss(board, depth)
    elsif board.full?
      DRAW_SCORE
    end
  end

  def score_win_or_loss(board, depth)
    if winner_mark(board) == mark
      WIN_SCORE - depth
    else
      LOSE_SCORE + depth
    end
  end

  def winner_mark(board)
    board.winner_mark
  end

  def make_next_board(position)
    board.make_next_board(position, mark)
  end

  def swap_mark(current_mark)
    current_mark == mark ? opponent_mark : mark
  end
end
