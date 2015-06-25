require 'player'

describe Player do

  it 'gets move from user' do
    ui = instance_double(GamePlayUi, get_move_from_user: 0).as_null_object
    player = Player.new("x", ui)
    expect(player.pick_position).to eq(0)
  end
end
