require 'cli'

class GamePlayUi
  def initialize(cli)
    @cli = cli
  end

  INVALID_OPTION_NOTICE    = "******************************\nINVALID option, please try again\n******************************"
  MOVE_REQUEST = "Please enter position to play into"
  WINNER_ANNOUNCEMENT = "And the winner is - "
  GAME_OVER = "GAME OVER"
  GAME_DRAWN = "It's a DRAW"
  NEW_LINE = "\n"
  PADDING = ' '

  def notify_of_invalid_option
    show(INVALID_OPTION_NOTICE)
  end

  def get_move_from_user(mark)
    show("Player #{mark} " + MOVE_REQUEST)
    get_move
  end

  def display_board(board)
    show(draw(board))
  end

  def display_winner(player)
    show(WINNER_ANNOUNCEMENT + player.to_s)
  end

  def display_game_over
    show(GAME_OVER)
  end

  def display_draw
    show(GAME_DRAWN)
  end

  private
  attr_reader :cli

  def show(message)
    cli.show(message)
  end

  def get_input
    cli.get_input
  end

  def display_player_options
    show(PLAYER_OPTIONS)
  end

  def get_move
    normalize(get_input)
  end

  def draw(board)
    offset(board_state(board)).map do |row|
      add_row_padding(row)
    end
    .join(row_border(board.size)) + NEW_LINE
  end

  def add_row_padding(row)
    row.map do |position|
      position = position.to_s
      add_cell_padding(position)
    end
    .join('|')
  end

  def add_cell_padding(value)
    PADDING * padding_amount(value) + value + PADDING
  end

  def padding_amount(value)
    max_padding = 2
    max_padding / value.length
  end

  def row_border(size)
    NEW_LINE + border_line(size) + NEW_LINE
  end

  def border_line(size)
    ('-----'*size)[0..-2]
  end

  def board_state(board)
    board.state_by_rows
  end

  def offset(board_state)
    board_state.map do |row|
      offset_line(row)
    end
  end

  def offset_line(line)
    line.map do |p| 
      p.is_a?(Numeric) ? p + 1 : p
    end
  end

  def normalize(move)
    move.to_i - 1
  end
end
