class GameSelectorUi

  def initialize(cli)
    @cli = cli
  end

  GREETING = "Welcome to TicTacToe"
  GAME_TYPE_OPTIONS = "You have 2 options:\nc - Play against computer\nh - Play against your friend\nPlease enter option 'c' or 'h'"
  FIRST_PLAYER_OPTIONS = "Who plays first?\nc - computer plays first\nh - you play first"
  HUMAN_GAME_INSTRUCTIONS = "Each player enters move in turn\nFirst player is assigned 'X' mark"

  def greet
    show(GREETING)
  end

  def display_game_type_options
    show(GAME_TYPE_OPTIONS)
  end

  def display_first_player_options
    show(FIRST_PLAYER_OPTIONS)
  end

  def get_game_type
    display_game_type_options
    get_clean_input
  end

  def get_first_player
    display_first_player_options
    get_clean_input
  end

  def show_human_instructions
    show(HUMAN_GAME_INSTRUCTIONS)
  end

  private
  attr_reader :cli

  def show(message)
    cli.show(message)
  end

  def get_clean_input
    cli.get_clean_input
  end
end
