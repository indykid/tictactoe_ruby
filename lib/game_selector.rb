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
    players = make_players(get_game_type)
    game_class.new(board, game_play_ui, players[:player_x], players[:player_o])
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
    end
    { player_x: player_x, player_o: player_o }
  end

  def get_game_type
    game_type = game_selector_ui.get_game_type
    case game_type
    when 'c'
      get_first_player
    when 'h'
      'hvh'
    end
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

  private
  attr_reader :game_selector_ui, :human_class, :game_play_ui, :ai_class, :board, :game_class

  def make_human_player(mark)
    human_class.new(mark, game_play_ui)
  end

  def make_ai_player(mark)
    ai_class.new(mark, board)
  end
end


class GameSelectorUi

  def initialize(input, output)
    @input = input
    @output = output
  end

  GAME_TYPE_OPTIONS = "You have 2 options:\nc - Play against computer\nh - Play against your friend\nPlease enter option 'c' or 'h'"
  FIRST_PLAYER_OPTIONS = "Who plays first?\nc - computer plays first\nh - you play first"

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

  private
  include Ui

  attr_reader :input, :output
end
