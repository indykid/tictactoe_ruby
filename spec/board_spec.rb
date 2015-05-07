require 'board'
describe Board do
  it 'is empty at the start' do
    board = Board.new
    expect(board.cells).to eq([])
  end
end
