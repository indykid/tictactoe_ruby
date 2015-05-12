require 'player'
describe Player do

  it 'gets move from user' do
    player = Player.new(:x)
    ui = FakeUi.new(StringIO.new('0'))
    expect(player.move(ui)).to eq(0)
   
  end
end

class FakeUi
  def initialize(input)
    @input = input
  end

  def ask_for_move
    @input.gets.chomp.to_i
  end
end


