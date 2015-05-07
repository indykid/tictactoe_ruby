require 'board'
describe Board do
  let(:board) { Board.new }

  it 'is empty at the start' do
    expect(board.cells).to eq([])
  end

  it 'has a default size' do
    expect(board.size).to eq(3)
  end

end
