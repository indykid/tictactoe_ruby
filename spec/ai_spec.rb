require 'ai'

describe Ai do

  let(:ai) { Ai.new(:x) }
  
  it 'assigns winning score to a win' do
    board = make_win_board
     
    expect(ai.score(board, :x, 0)).to eq(10)
  end

  it 'assigns losing score to a loss' do
    board = make_loss_board

    expect(ai.score(board, :x, 0)).to eq(-10)
  end

  it 'assigns draw score to a draw' do
    board = make_draw_board

    expect(ai.score(board, :x, 0)).to eq(0)
  end

  it 'scores intermediate board state based on the following end state' do
    board = Board.new([:x, :o,  :x,
                       :x, :x,  :o,
                       :o, :o, nil])

    expect(ai.score(board, :x, 0)).to eq(9)
  end

  it 'correctly scores intermediate board states based on the following end state regardless of Ai mark' do
    board = Board.new([:x, :x, :o,
                       :o, :x, :o,
                       :x, nil, nil])
    ai = Ai.new(:o)

    expect(ai.score(board, :o, 0)).to eq(9)
  end

  it 'correctly scores intermediate board state with 6 possible outcomes' do
    board = Board.new([nil, :o, :x,
                       nil, :o, nil,
                       :x, :x, :o])

    expect(ai.score(board, :x, 0)).to eq(0)
  end

  it 'scores intermediate state with max 24 potential outcomes' do
    board = Board.new([ :x, :o, :x,
                       nil, :o, nil,
                       nil, :x, nil ])
    expect(ai.score(board, :o, 0)).to eq(0)
  end

  it 'returns win score for intermediate state with possible win for x player' do
    board = Board.new([ :o, nil, :x,
                        :x, nil, nil,
                        :x, :o,  :o ])
    expect(ai.score(board, :x, 0)).to eq(9)
  end

  it 'returns win score for intermediate state with immediate possible win' do
    board = Board.new([ :o, :x, :x,
                        :x, nil, nil,
                        :x, :o,  :o ])

    ai = Ai.new(:o)
    expect(ai.score(board, :o, 0)).to eq(9)
  end

  it 'scores correctly' do
    board = Board.new([nil, :o, :o,
                       nil, nil, :x,
                       nil, nil, :x ])

    ai = Ai.new(:o)
    expect(ai.score(board, ai.mark, 0)).to eq(9)
  end

  it 'plays into winning position' do
    board = Board.new([ :x, :o, nil,
                        nil, :o, nil,
                       :x, nil, nil ])
    ai = Ai.new(:x)

    expect(ai.pick_position(board)).to eq(3)
  end

  it 'plays into blocking position at a threat' do
    board = Board.new([ :x, :x, :o,
                       nil, :o, nil,
                       nil, nil, nil ])
    ai = Ai.new(:x)

    expect(ai.pick_position(board)).to eq(6)
  end

  it 'plays into blocking position at a threat' do
    board = Board.new([nil, nil, nil,
                       nil, :x, nil,
                       nil, :x, :o ])
    ai = Ai.new(:o)

    expect(ai.pick_position(board)).to eq(1)
  end

  it 'plays into blocking position at a threat' do
    board = Board.new([nil, :o, :o,
                       nil, nil, :x,
                       nil, nil, :x ])
    ai = Ai.new(:x)

    expect(ai.pick_position(board)).to eq(0)
  end

  it 'plays into blocking position at a threat' do
    board = Board.new([nil, nil, nil,
                       nil, :x, :x,
                       nil, nil, :o ])
    ai = Ai.new(:o)

    expect(ai.pick_position(board)).to eq(3)
  end

  it 'blocks' do
    board = Board.new([:o, nil, :x,
                       nil, :x, nil,
                       nil, nil, nil ])
    ai = Ai.new(:o)
    expect(ai.pick_position(board)).to eq(6)
  end

  it 'wins fast' do
    board = Board.new([ :o, :o, nil,
                        :x, :x, nil,
                       nil, nil, nil ])
    ai = Ai.new(:x)

    expect(ai.pick_position(board)).to eq(5)
  end

  it 'wins fast' do
    board = Board.new([ :o, nil, nil,
                        :x, :x, nil,
                       nil, :o, nil ])
    ai = Ai.new(:x)

    expect(ai.pick_position(board)).to eq(5)
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
end
