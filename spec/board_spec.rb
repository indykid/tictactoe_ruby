require 'board'
describe Board do
  let(:board) { Board.new }

  it 'is empty at the start' do
    expect(board.cells).to eq([])
  end

  it 'has a default size' do
    expect(board.size).to eq(3)
  end

  it 'records moves' do
    board.add_move(0)
    expect(board.cells).to eq([0])
  
  end
end
