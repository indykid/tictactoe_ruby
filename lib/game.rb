class Game
  def initialize(board, player_x, player_o, ui)
    @board = board
    @player_x = player_x
    @player_o = player_o
    @ui = ui
    @queue = queue
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

  def play
    while !over?
      play_turn
    end
    ui.visualise(board)
  end

  def play_turn
    ui.visualise(board)
    current_player = player_in_turn
    position = current_player.pick_move(ui)
    if valid_move?(position)
      board.add_move(position, current_player.mark)
    else
      ui.show(Ui::ALERT)
    end
  end

  private

  attr_reader :board, :ui

  def valid_move?(position)
    board.available.include?(position)
  end

  def player_in_turn
    #board.moves.length.even? ? @player_x : @player_o
    @queue.next
  end 

  def queue
    [@player_x, @player_o].cycle
  end
end
