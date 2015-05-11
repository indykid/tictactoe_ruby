require 'board'
describe Board do
  let(:board) { Board.new }

  it 'has cells' do
    expect(board.cells).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end

  it 'has cells amount based on size' do
    board = Board.new(4)
    expect(board.cells).to eq([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])
  end

  it 'is empty at the start' do
    expect(board.moves).to eq([])
  end

  it 'has a default size' do
    expect(board.size).to eq(3)
  end

  it 'records moves' do
    board.add_move(0, 'x')
    expect(board.moves).to eq([{position: 0, player: 'x'}])
  end

  it 'knows if cell is not taken' do
    expect(board.taken?(0)).to be(false)
  end

  it 'knows if cell is taken' do
    board.add_move(0, 'x')
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

  it 'knows if a given line is full with the same player' do
    board.add_move(0, 'x')
    board.add_move(1, 'x')
    board.add_move(2, 'x')
    expect(board.taken_by_same_player?([0, 1, 2])).to be(true)
  end

  it 'knows if a given line is not full with the same player' do
    board.add_move(0, 'o')
    board.add_move(1, 'x')
    board.add_move(2, 'x')
    expect(board.taken_by_same_player?([0, 1, 2])).to be(false)
  end

  it 'knows if given line is not full even if same player' do
    board.add_move(0, 'x')
    board.add_move(1, 'x')
    expect(board.taken_by_same_player?([0, 1, 2])).to be(false)
  end

  it 'knows it is not full' do
    expect(board.full?).to be(false)
  end

  it 'knows it is full' do
    board.add_move(0, 'x')
    board.add_move(1, 'o')
    board.add_move(2, 'x')
    board.add_move(3, 'o')
    board.add_move(4, 'o')
    board.add_move(5, 'x')
    board.add_move(6, 'x')
    board.add_move(7, 'x')
    board.add_move(8, 'o')
    expect(board.full?).to be(true)
  end
end




















