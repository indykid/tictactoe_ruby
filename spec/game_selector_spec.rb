require 'game_selector'

describe GameSelector do

  let(:ui) { instance_double(GameSelectorUi).as_null_object }
  let(:board) { Board.new }
  let(:game_play_ui) { instance_double(GamePlayUi) }
  let(:game_selector) { GameSelector.new(Game, Player, Ai, board, ui, game_play_ui) }

  it 'makes game' do
    expect(game_selector.make_game).to be_instance_of(Game)
  end

  it 'creates players with correct marks' do
    players = game_selector.make_players('hvh')

    expect(players[:player_x].mark).to eq(:x)
    expect(players[:player_o].mark).to eq(:o)
  end

  it 'returns human players for hvh game' do
    players = game_selector.make_players('hvh')

    expect(players[:player_x]).to be_instance_of(Player)
    expect(players[:player_o]).to be_instance_of(Player)
  end

  it 'returns correct players for cvh game' do
    players = game_selector.make_players('cvh')

    expect(players[:player_x]).to be_instance_of(Ai)
    expect(players[:player_o]).to be_instance_of(Player)
  end

  it 'returns correct players for hvc game' do
    players = game_selector.make_players('hvc')

    expect(players[:player_x]).to be_instance_of(Player)
    expect(players[:player_o]).to be_instance_of(Ai)
  end

  it 'asks for game type choice' do
    game_selector.get_game_type

    expect(ui).to have_received(:get_game_type)
  end

end
