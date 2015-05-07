require 'board'
describe Board do
  it 'is empty at the start' do
    board = Board.new
    expect(board.cells).to eq([])
  end

  it 'has a default size' do
    board = Board.new
    expect(board.size).to eq(3)
  end
end
