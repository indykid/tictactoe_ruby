require 'game_selector'
require 'game'
require 'player'
require 'ai'
require 'board'
require 'game_selector_ui'
require 'game_play_ui'

describe GameSelector do

  let(:ui) { instance_double(GameSelectorUi).as_null_object }
  let(:game_play_ui) { instance_double(GamePlayUi) }
  let(:game_selector) { GameSelector.new(Game, Player, Ai, Board, ui, game_play_ui) }

  it 'gets selector ui to greet' do
    allow(ui).to receive(:get_game_size)
    game_selector.make_game

    expect(ui).to have_received(:greet)
  end

  it 'asks for game size' do
    allow(ui).to receive(:get_game_size)
    game_selector.make_game

    expect(ui).to have_received(:get_game_size)
  end

  it 'asks for game type choice' do
    allow(ui).to receive(:get_game_size)
    game_selector.make_game

    expect(ui).to have_received(:get_game_type)
  end

  it 'makes game' do
    allow(ui).to receive(:get_game_size)
    expect(game_selector.make_game).to be_instance_of(Game)
  end

  it 'creates players with correct marks' do
    player_x, player_o = game_selector.make_players('hvh')

    expect(player_x.mark).to eq(:x)
    expect(player_o.mark).to eq(:o)
  end

  it 'returns human players for human vs human game' do
    player_x, player_o = game_selector.make_players('hvh')

    expect(player_x).to be_instance_of(Player)
    expect(player_o).to be_instance_of(Player)
  end

  it 'returns computer players for computer vs computer game' do
    player_x, player_o = game_selector.make_players('cvc')

    expect(player_x).to be_instance_of(Ai)
    expect(player_o).to be_instance_of(Ai)
  end

  it 'returns computer as x and human as o players for computer vs human game' do
    player_x, player_o = game_selector.make_players('cvh')

    expect(player_x).to be_instance_of(Ai)
    expect(player_o).to be_instance_of(Player)
  end

  it 'returns human as x and computer as o players for human vs computer game' do
    players = game_selector.make_players('hvc')
    player_x, player_o = game_selector.make_players('hvc')

    expect(player_x).to be_instance_of(Player)
    expect(player_o).to be_instance_of(Ai)
  end
end
