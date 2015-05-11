require 'player'
describe Player do

  it 'makes moves' do
    board = Board.new
    player = Player.new(:x)

    player.move(board, 0)

    expect(board.moves.first[:position]).to eq(0)
    expect(board.moves.first[:mark]).to eq(:x)
  end
end
