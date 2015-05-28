require 'player'
describe Player do

  it 'gets move from user' do
    player = Player.new(:x)
    ui = FakeUi.new(StringIO.new, StringIO.new('0'))
    expect(player.pick_position(ui)).to eq(0)
  end
end
