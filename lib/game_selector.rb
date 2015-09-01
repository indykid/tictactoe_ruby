class PlayerFactory
  def self.make_players(players_code, ui)
    case players_code
    when 'hvh'
      player_x = make_human_player(:x, ui)
      player_o = make_human_player(:o, ui)
    when 'cvh'
      player_x = make_ai_player(:x, :o)
      player_o = make_human_player(:o, ui)
    when 'hvc'
      player_x = make_human_player(:x, ui)
      player_o = make_ai_player(:o, :x)
    when 'cvc'
      player_x = make_ai_player(:x, :o)
      player_o = make_ai_player(:o, :x)
    end
    [player_x, player_o]
  end

  def self.make_human_player(mark, ui)
    Player.new(mark, ui)
  end

  def self.make_ai_player(mark, opponent_mark)
    Ai.new(mark, opponent_mark)
  end
end

class GameSelector
  def initialize(game_class, human_class, ai_class, board_class, game_selector_ui, game_play_ui)
    @game_selector_ui = game_selector_ui
    @human_class = human_class
    @ai_class = ai_class
    @game_class = game_class
    @board_class = board_class
    @game_play_ui = game_play_ui
  end

  def make_game
    greet
    game_class.new(
      board_class.new(nil, get_game_size),
      game_play_ui,
      *PlayerFactory.make_players(get_game_type, game_play_ui)
    )
  end

  private
  attr_reader :game_selector_ui, :human_class, :game_play_ui, :ai_class, :board_class, :game_class

  def get_game_size
    game_selector_ui.get_game_size
  end

  def get_game_type
    game_selector_ui.get_game_type
  end

  def greet
    game_selector_ui.greet
  end

  def show_human_instructions
    game_selector_ui.show_human_instructions
  end
end


