require 'ui'

class GamePlayUi

  def initialize(input, output)
    @input = input
    @output = output
  end

  GREETING = "Welcome to TicTacToe"
  HUMAN_GAME_INSTRUCTIONS = "Each player enters move in turn\nFirst player is assigned 'X' mark"
  INVALID_OPTION_NOTICE    = "******************************\nINVALID option, please try again\n******************************"
  MOVE_REQUEST = "Please enter position to play into"
  WINNER_ANNOUNCEMENT = "And the winner is - "
  GAME_OVER = "GAME OVER"
  GAME_DRAWN = "It's a DRAW"

  def greet
    show(GREETING)
  end

  def notify_of_invalid_option
    show(INVALID_OPTION_NOTICE)
  end

  def get_move_from_user(mark)
    show("Player #{mark} " + MOVE_REQUEST)
    get_move
  end

  def display_board(board_state)
    show(draw(board_state))
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
  attr_reader :input, :output

  include Ui

  def display_player_options
    show(PLAYER_OPTIONS)
  end

  def get_move
    normalize(get_input)
  end

  def draw(board_state)
      offset(board_state).map do |row|
      " " + row.join(" | ") + " "
      end
    .join("\n-----------\n") +
      "\n"
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
