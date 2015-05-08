require 'board'
describe Board do
  let(:board) { Board.new }

  it 'has cells' do
    expect(board.cells).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end

  it 'is empty at the start' do
    expect(board.moves).to eq([])
  end

  it 'has a default size' do
    expect(board.size).to eq(3)
  end

  it 'records moves' do
    board.add_move(0)
    expect(board.moves).to eq([0])
  end

  it 'knows if cell is not taken' do
    expect(board.taken?(0)).to be(false)
  end

  it 'knows if cell is taken' do
    board.add_move(0)
    expect(board.taken?(0)).to be(true)
  end

  it 'knows its rows' do
    expect(board.rows).to match_array([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
  end

  it 'knows its columns' do
    expect(board.columns).to match_array([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end

  it 'knows its diagonals' do
    expect(board.diagonals).to match_array([[0, 4, 8], [2, 4, 6]])
  end
end
