require 'spec_helper'
require 'board'

describe Board do
  it 'can be initialized with given moves' do
    board = Board.new([:x, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil])
    expect(board.mark_at(0)).to eq(:x)
  end

  it 'two boards are equal if have same moves' do
    board_one = make_one_move_board
    board_two = make_one_move_board

    expect(board_one).to eq(board_two)
  end

  it 'when adding move, it returns a new board with added move' do
    board = Board.new
    expect(board.add_move(0, :x)).to eq(Board.new([:x, nil, nil,
                                                  nil, nil, nil,
                                                  nil, nil, nil]))
  end

  it 'making move has no affect on the original board used to make it' do
    board = make_one_move_board
    
    expect { board.add_move(2, :o) }.to_not change { board }
  end

  it 'knows if move is valid' do
    board = Board.new
    expect(board.valid?(0)).to be(true)
  end

  it 'knows that occupied position is not valid' do
    board = make_one_move_board
    expect(board.valid?(0)).to be(false)
  end

  it 'knows that position outside the board is not valid' do
    board = Board.new
    expect(board.valid?(10)).to be(false)
  end

  it 'knows when it is not full' do
    board = make_one_move_board
    expect(board.full?).to be(false)
  end

  it 'knows when its full' do
    board = make_draw_board
    expect(board.full?).to be(true)
  end

  it 'knows available positions' do
    board = make_one_move_board
    expect(board.available).to match_array([1, 2, 3, 4, 5, 6, 7, 8])
  end

  it 'knows if there is a win on a row' do
    board = make_win_board
    expect(board.winner_line).to_not be(nil)
  end

  it 'knows if there is a win on a diagonal' do
    board = Board.new([:x, nil, nil, 
                      nil,  :x, nil, 
                      nil, nil, :x])
    expect(board.winner_line).to_not be(nil)
  end

  it 'knows if there is a win on a column' do
    board = Board.new([nil, nil, :x, 
                       nil, nil, :x, 
                       nil, nil, :x])
    expect(board.winner_line).to_not be(nil)
  end

  it 'returns state split by rows' do
    board = make_one_move_board
    expect(board.state_by_rows).to eq([[:x, 1, 2], [3, 4, 5], [6, 7, 8]])
  end

  it 'returns the mark for the same player line' do
    board = make_win_board
    expect(board.winner_mark).to eq(:x)
  end

  def make_draw_board
    Board.new([:x, :x, :o, 
               :o, :x, :x, 
               :x, :o, :o])
  end

  def make_win_board
    Board.new([:x, :x, :x, 
               :o, :o, nil, 
               nil, nil, nil])
  end

  def make_one_move_board
    Board.new([:x, nil, nil, 
               nil, nil, nil, 
               nil, nil, nil])
  end
end
