require 'ai'

describe Ai do

  let(:board) { Board.new }
  xit 'picks winning move if there is one' do
    ai = Ai.new(:x)
    add_moves([0, 1], :x)
    add_moves([4, 5], :o)
    expect(ai.pick_position).to eq(2)
  end
  
  it 'assigns winning score to a win' do
    ai = Ai.new(:x)
    board = make_win_board
     
    expect(ai.score(board)).to eq(Ai::WIN_SCORE)
  end

  it 'assigns losing score to a loss' do
    ai = Ai.new(:x)
    board = make_loss_board

    expect(ai.score(board)).to eq(Ai::LOSE_SCORE)
  end

  it 'assigns draw score to a draw' do
    ai = Ai.new(:x)
    board = make_draw_board

    expect(ai.score(board)).to eq(Ai::DRAW_SCORE)
  end

  it 'knows child states of the given board' do
    ai = Ai.new(:x)
    board = Board.new([:x, :o, nil, :x, :x, :o, :o, nil, nil])
    children = ai.find_children(board, ai.mark)
    available = children.map {|c| c.available_positions }

    expect(available).to match_array(possible_combinations_for(board.available_positions))
  end

  it 'knows child states of the board with one move' do
    ai = Ai.new(:x)
    board = make_one_move_board
    children = ai.find_children(board, ai.mark)
    available = children.map {|c| c.available_positions }

    expect(available).to match_array(possible_combinations_for(board.available_positions))
  end

  it 'produces as many child states as there are available moves' do
    ai = Ai.new(:x)
    board = Board.new([:x, nil, nil, :x, :x, :o, :o, nil, nil])
    children = ai.find_children(board, ai.mark)

    expect(children.count).to eq(board.available_positions.count)
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

  def possible_combinations_for(available_positions)
    remaining_available_count = available_positions.count - 1
    available_positions.combination(remaining_available_count)
  end
end
