require 'ai'

describe Ai do

  let(:board) { Board.new }
  let(:ai)    { Ai.new(:x) }

  xit 'picks winning move if there is one' do
    add_moves([0, 1], :x)
    add_moves([4, 5], :o)
    expect(ai.pick_position).to eq(2)
  end
  
  it 'assigns winning score to a win' do
    board = make_win_board
     
    expect(ai.score(board, :x)).to eq(Ai::WIN_SCORE)
  end

  it 'assigns losing score to a loss' do
    board = make_loss_board

    expect(ai.score(board, :x)).to eq(Ai::LOSE_SCORE)
  end

  it 'assigns draw score to a draw' do
    board = make_draw_board

    expect(ai.score(board, :x)).to eq(Ai::DRAW_SCORE)
  end

  it 'knows child states of the given board' do
    board = Board.new([:x, :o, nil,
                       :x, :x, :o, 
                       :o, nil, nil])
    children = ai.possible_boards(board, ai.mark)
    available = children.map {|c| c.available_positions }

    expect(available).to match_array(possible_combinations_for(board.available_positions))
  end

  it 'knows child states of the board with one move' do
    board = make_one_move_board
    children = ai.possible_boards(board, ai.mark)
    available = children.map {|c| c.available_positions }

    expect(available).to match_array(possible_combinations_for(board.available_positions))
  end

  it 'calculates as many child states as there are available moves' do
    board = Board.new([:x, nil, nil,
                       :x, :x,  :o,
                       :o, nil, nil])
    children = ai.possible_boards(board, ai.mark)

    expect(children.count).to eq(4)
  end

  it 'scores intermediate board state based on the following end state' do
    board = Board.new([:x, :o,  :x,
                       :x, :x,  :o,
                       :o, :o, nil])

    expect(ai.score(board, :x)).to eq(Ai::WIN_SCORE)
  end

  it 'scores intermediate board states based on the following end state regardless of Ai mark' do
    ai = Ai.new(:o)
    board = Board.new([:x, :x, :o,
                       :o, :x, :o,
                       :x, nil, nil])

    expect(ai.score(board, :o)).to eq(Ai::WIN_SCORE)
  end

  it 'correctly scores intermediate board state with 6 possible outcomes' do
    board = Board.new([nil, :o, :x,
                       nil, :o, nil,
                       :x, :x, :o])

    expect(ai.score(board, :x)).to eq(Ai::DRAW_SCORE)
  end

  def make_draw_board
    Board.new([:x, :x, :o,
               :o, :x, :x,
               :x, :o, :o])
  end

  def make_win_board
    Board.new([:x,  :x,  :x,
               :o,  :o,  nil,
               nil, nil, nil])
  end

  def make_loss_board
    Board.new([:x, :x,  :o,
               :x, :o,  nil,
               :o, nil, nil])
  end

  def make_one_move_board
    Board.new([:x,  nil, nil,
               nil, nil, nil,
               nil, nil, nil])
  end

  def possible_combinations_for(available_positions)
    remaining_available_count = available_positions.count - 1
    available_positions.combination(remaining_available_count)
  end
end
