require 'player'
describe Player do

  it 'gets move from user' do
    player = Player.new(:x)
    ui = Ui.new(StringIO.new, StringIO.new('0'))
    expect(player.pick_move(ui)).to eq(0)
  end
end
