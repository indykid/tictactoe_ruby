require 'spec_helper'
require 'board'

describe Board do

  it 'records player moves' do
    board = make_one_move_board
    expect(board.mark_at(0)).to eq("x")
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
    expect(board.available_positions).to match_array([1, 2, 3, 4, 5, 6, 7, 8])
  end

  it 'knows if there is a win on a row' do
    board = make_win_board
    expect(board.winner_line).to_not be(nil)
  end

  it 'knows if there is a win on a diagonal' do
    board = Board.new(["x", nil, nil, nil, "x", nil, nil, nil, "x"])
    expect(board.winner_line).to_not be(nil)
  end

  it 'knows if there is a win on a column' do
    board = Board.new([nil, nil, "x", nil, nil, "x", nil, nil, "x"])
    expect(board.winner_line).to_not be(nil)
  end

  it 'returns state split by rows' do
    board = make_one_move_board
    expect(board.state_by_rows).to eq([["x", 1, 2], [3, 4, 5], [6, 7, 8]])
  end

  it 'returns the mark for the same player line' do
    board = make_win_board
    expect(board.winner_mark).to eq("x")
  end

  it 'makes next possible board' do
    board = make_one_move_board
    next_board = board.make_next_board(1, "o")

    expect(next_board.available_positions).to match_array([2, 3, 4, 5, 6, 7, 8])
  end

  it 'changes to the next possible board have no affect on the original board used to make it' do
    board = make_one_move_board
    next_board = board.make_next_board(1, "o")
    
    expect { next_board.add_move(2, "x") }.to_not change { board }
  end

  it 'changes to one next possible board have no affect on another next board even if they both came from the same original board' do
    board = make_one_move_board
    next_board_one = board.make_next_board(1, "o")
    next_board_two = board.make_next_board(2, "o")
    
    expect { next_board_one.add_move(3, "x") }.to_not change { next_board_two }
  end

  def make_draw_board
    Board.new(["x", "x", "o", 
               "o", "x", "x", 
               "x", "o", "o"])
  end

  def make_win_board
    Board.new(["x", "x", "x", 
               "o", "o", nil, 
               nil, nil, nil])
  end

  def make_one_move_board
    Board.new(["x", nil, nil, 
               nil, nil, nil, 
               nil, nil, nil])
  end
end
