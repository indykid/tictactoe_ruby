require 'ai'

describe Ai do

  let(:board) { Board.new }
  xit 'picks winning move if there is one' do
    ai = Ai.new(:x)
    add_moves([0, 1], :x)
    add_moves([4, 5], :o)
    expect(ai.pick_position).to eq(2)
  end
  
  it 'assigns score 10 to a win' do
    ai = Ai.new(:x)
    board = make_win_board
     
    expect(ai.score(board)).to eq(Ai::WIN_SCORE)
  end

  it 'assigns score -10 to a loss' do
    ai = Ai.new(:x)
    board = make_loss_board

    expect(ai.score(board)).to eq(Ai::LOSE_SCORE)
  end

  it 'assigns score 0 to a draw' do
    ai = Ai.new(:x)
    board = make_draw_board

    expect(ai.score(board)).to eq(Ai::DRAW_SCORE)
  end

  it 'knows child states of the given board' do
    ai = Ai.new(:x)
    board = Board.new([:x, :o, nil, :x, :x, :o, :o, nil, nil])
    children = ai.find_children(board, ai.mark)
    available = children.map {|c| c.available_positions }

    expect(available).to match_array([[7, 8], [2, 8], [2, 7]])

  end

  def make_draw_board
    Board.new([:x, :x, :o, :o, :x, :x, :x, :o, :o])
  end

  def make_win_board
    Board.new([:x, :x, :x, :o, :o, nil, nil, nil, nil])
  end

  def make_loss_board
    Board.new([:x, :x, :o, :x, :o, nil, :o, nil, nil])
  end

  def make_one_move_board
    Board.new([:x, nil, nil, nil, nil, nil, nil, nil, nil])
  end
end
