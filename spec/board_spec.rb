require 'spec_helper'
require 'board'

describe Board do

  let(:board) { Board.new }

  it 'records player moves' do
    board.add_move(0, :x)
    expect(board.player_at(0)).to eq(:x)
  end

  it 'knows all its available moves' do
    add_moves([0, 2], :x)
    board.add_move(1, :o)
    expect(board.available_positions).to match_array([3, 4, 5, 6, 7, 8])
  end

  it 'knows when it is not full' do
    board.add_move(1, :x)
    expect(board.full?).to be(false)
  end

  it 'knows when its full' do
    fill_up
    expect(board.full?).to be(true)
  end

  it 'knows if there is a same player line' do
    add_moves([0, 1, 2], :x)
    expect(board.any_same_player_line?).to be(true)
  end


end
