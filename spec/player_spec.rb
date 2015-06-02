require 'player'
require 'support/doubles/fake_ui.rb'

describe Player do

  it 'gets move from user' do
    ui = FakeUi.new([0])
    player = Player.new(:x, ui)
    expect(player.pick_position).to eq(0)
  end
end
