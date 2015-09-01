require 'player_factory'
require 'game'
require 'player'
require 'ai'
require 'board'

describe PlayerFactory do
  let(:ui) { double.as_null_object }
  it 'creates players with correct marks' do
    player_x, player_o = described_class.make_players('hvh', ui)

    expect(player_x.mark).to eq(:x)
    expect(player_o.mark).to eq(:o)
  end

  it 'returns human players for human vs human game' do
    player_x, player_o = described_class.make_players('hvh', ui)

    expect(player_x).to be_instance_of(Player)
    expect(player_o).to be_instance_of(Player)
  end

  it 'returns computer players for computer vs computer game' do
    player_x, player_o = described_class.make_players('cvc', ui)

    expect(player_x).to be_instance_of(AiNegamax)
    expect(player_o).to be_instance_of(AiNegamax)
  end

  it 'returns computer as x and human as o players for computer vs human game' do
    player_x, player_o = described_class.make_players('cvh', ui)

    expect(player_x).to be_instance_of(AiNegamax)
    expect(player_o).to be_instance_of(Player)
  end

  it 'returns human as x and computer as o players for human vs computer game' do
    player_x, player_o = described_class.make_players('hvc', ui)

    expect(player_x).to be_instance_of(Player)
    expect(player_o).to be_instance_of(AiNegamax)
  end
end
