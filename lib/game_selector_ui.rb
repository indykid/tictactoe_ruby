require 'tictactoe_core/player_factory'
require 'tictactoe_core/game'
require 'tictactoe_core/board'
require 'game_play_ui'

class GameSelectorUi
  GREETING          = "Welcome to TicTacToe"
  GAME_SIZE_OPTIONS = "Enter 4 for 4x4 game, or any key for 3x3"
  GAME_TYPE_OPTIONS = "You have 4 options:\ncvc - Computer against computer\nhvc - You play first against computer\ncvh - Computer plays first againt you\nhvh - You plays against your friend\nPlease enter option 'cvc', 'hvc', 'cvh' or 'hvh'"
  HUMAN_GAME_INSTRUCTIONS = "Each player enters move in turn\nFirst player is assigned 'X' mark"

  def initialize(cli)
    @cli = cli
  end

  def greet
    show(GREETING)
  end

  def get_game_size
    show(GAME_SIZE_OPTIONS)
    get_clean_input
  end

  def get_game_type
    show(GAME_TYPE_OPTIONS)
    get_clean_input
  end

  def show_human_instructions
    show(HUMAN_GAME_INSTRUCTIONS)
  end

  def make_game
    greet
    game_play_ui = GamePlayUi.new(cli)
    TictactoeCore::Game.new(
      TictactoeCore::Board.new(nil, get_game_size),
      game_play_ui,
      *TictactoeCore::PlayerFactory.make_players(get_game_type, game_play_ui)
    )
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
