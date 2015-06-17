require 'invalid_move_error'

class Ui

  def initialize(input, output)
    @input = input
    @output = output
  end

  PLAYER_OPTIONS = "You have 2 options:\nc - Play against computer\nh - Play against your friend\nPlease enter option 'c' or 'h'"
  GREETING = "Welcome to TicTacToe"
  HUMAN_GAME_INSTRUCTIONS = "Each player enters move in turn\nFirst player is assigned 'X' mark"
  ALERT    = "******************************\nINVALID option, please try again\n******************************"
  MOVE_REQUEST = "Please enter position to play into"
  WINNER_ANNOUNCEMENT = "And the winner is - "
  GAME_OVER = "GAME OVER"
  GAME_DRAWN = "It's a DRAW"

  def main_menu
    greet
    game_type = get_player_options

    while !valid_game_type(game_type)
      alert
      game_type = get_player_options
    end

    if game_type == 'c'
      get_first_player
    elsif game_type == 'h'
      show(HUMAN_GAME_INSTRUCTIONS)
      'hvh'
    end
  end

  def get_player_options
    display_player_options
    input.gets.chomp
  end
  
  def get_first_player
    show("Who plays first?\nc - computer plays first\nh - you play first")
    first = input.gets.chomp
  end

  def valid_game_type(game_type)
    ['c', 'h'].include?(game_type)
  end

  def greet
    show(GREETING)
  end

  def alert
    show(ALERT)
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

  def display_player_options
    show(PLAYER_OPTIONS)
  end

  def get_move
    normalize(input.gets)
  end

  def show(message)
    output.puts("\n" + message)
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
