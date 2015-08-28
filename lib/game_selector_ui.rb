class GameSelectorUi

  def initialize(cli)
    @cli = cli
  end

  GREETING = "Welcome to TicTacToe"
  GAME_SIZE_OPTIONS = "Enter 4 for 4x4 game, or any key for 3x3"
  GAME_TYPE_OPTIONS = "You have 4 options:\ncvc - Computer against computer\nhvc - You play first against computer\ncvh - Computer plays first againt you\nhvh - You plays against your friend\nPlease enter option 'cvc', 'hvc', 'cvh' or 'hvh'"
  HUMAN_GAME_INSTRUCTIONS = "Each player enters move in turn\nFirst player is assigned 'X' mark"

  def greet
    show(GREETING)
  end

  def get_game_size
    show(GAME_SIZE_OPTIONS)
    get_clean_input
  end

  def get_game_type
    display_game_type_options
    get_clean_input
  end

  def show_human_instructions
    show(HUMAN_GAME_INSTRUCTIONS)
  end

  private
  attr_reader :cli

  def display_game_type_options
    show(GAME_TYPE_OPTIONS)
  end

  def show(message)
    cli.show(message)
  end

  def get_clean_input
    cli.get_clean_input
  end
end
