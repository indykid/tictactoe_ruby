require 'game_selector'

describe GameSelector do

  let(:ui) { instance_double(GameSelectorUi).as_null_object }
  let(:board) { Board.new }
  let(:game_play_ui) { instance_double(GamePlayUi) }
  let(:game_selector) { GameSelector.new(Game, Player, Ai, board, ui, game_play_ui) }

  it 'gets game_selector_ui to greet' do
    game_selector.make_game

    expect(ui).to have_received(:greet)
  end

  it 'makes game' do
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

  it 'asks for game type choice' do
    game_selector.make_game

    expect(ui).to have_received(:get_game_type)
  end

  it 'asks for first player when human plays against computer' do
    allow(ui).to receive(:get_game_type).and_return('c')
    game_selector.make_game

    expect(ui).to have_received(:get_first_player)
  end
end
