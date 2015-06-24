class GameSelector

  def initialize(game_class, human_class, ai_class, board, game_selector_ui, game_play_ui)
    @game_selector_ui = game_selector_ui
    @human_class = human_class
    @ai_class = ai_class
    @game_class = game_class
    @board = board
    @game_play_ui = game_play_ui
  end

  def make_game
    greet
    game_class.new(board, game_play_ui, *make_players(get_game_type))
  end

  def make_players(players_code)
    case players_code
    when 'hvh'
      player_x = make_human_player(:x)
      player_o = make_human_player(:o)
    when 'cvh'
      player_x = make_ai_player(:x)
      player_o = make_human_player(:o)
    when 'hvc'
      player_x = make_human_player(:x)
      player_o = make_ai_player(:o)
    when 'cvc'
      player_x = make_ai_player(:x)
      player_o = make_ai_player(:o)
    end
    [player_x, player_o]
  end

  private
  attr_reader :game_selector_ui, :human_class, :game_play_ui, :ai_class, :board, :game_class

  def get_game_type
    game_type = game_selector_ui.get_game_type
  end

  def greet
    game_selector_ui.greet
  end

  def make_human_player(mark)
    human_class.new(mark, game_play_ui)
  end

  def make_ai_player(mark)
    ai_class.new(mark, board)
  end

  def get_first_player
    first = game_selector_ui.get_first_player
    case first
    when 'c'
      'cvh'
    when 'h'
      'hvc'
    end
  end

  def show_human_instructions
    game_selector_ui.show_human_instructions
  end
end


