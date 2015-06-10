require 'spec_helper'
require 'board'

describe Board do

  it 'records player moves' do
    board = make_one_move_board
    expect(board.player_at(0)).to eq(:x)
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

  it 'knows if there is a same player row' do
    board = make_win_board
    expect(board.same_player_line?).to be(true)
  end

  it 'knows if there is a same player diagonal' do
    board = Board.new([:x, nil, nil, nil, :x, nil, nil, nil, :x])
    expect(board.same_player_line?).to be(true)
  end

  it 'knows if there is a same player column' do
    board = Board.new([nil, nil, :x, nil, nil, :x, nil, nil, :x])
    expect(board.same_player_line?).to be(true)
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
    Board.new([:x, :x, :o, :o, :x, :o, :x, :o, :x])
  end

  def make_win_board
    Board.new([:x, :x, :x, :o, :o, nil, nil, nil, nil])
  end

  def make_one_move_board
    Board.new([:x, nil, nil, nil, nil, nil, nil, nil, nil])
  end
end
