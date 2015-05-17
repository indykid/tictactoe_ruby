class Game
  def initialize(board, player_x, player_o, ui)
    @board = board
    @player_x = player_x
    @player_o = player_o
    @ui = ui
  end

  def over?
    winner? || draw?
  end

  def winner?
    board.any_same_player_line?
  end

  def draw?
    !winner? && board.full?
  end

  def play_turn
    @ui.visualise(board)
    position = player_in_turn.pick_move(@ui)
    if valid_move?(position)
      board.add_move(position, player_in_turn.mark)
    else
      @ui.show(Ui::ALERT)
    end
  end

  def play
    while !over?
      play_turn
    end
    @ui.visualise(board)
  end

  private

  def valid_move?(position)
    !board.taken?(position) && board.cells.include?(position)
  end

  def player_in_turn
    board.moves.length.even? ? @player_x : @player_o
  end 

  private

  attr_reader :board
end
