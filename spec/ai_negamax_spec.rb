require 'ai_negamax'

describe AiNegamax do
  let(:ai) { AiNegamax.new(:x, :o) }

  it 'returns winner score if result is a win' do
    expect(ai.end_score(:win, 0)).to eq(10)
  end

  it 'returns loser score if result is a loss' do
    expect(ai.end_score(:loss, 0)).to eq(-10)
  end

  it 'returns draw score if drawn' do
    expect(ai.end_score(:draw, 0)).to eq(0)
  end

  it 'knows win result' do
    board = Board.new([:x, :x, :x,
                       :o, :o, nil,
                      nil, nil, nil])

    expect(ai.end_result(board)).to eq(:win)
  end

  it 'knows loss result' do
    board = Board.new([:x, :x, :o,
                       :o, :o, :x,
                       :o, nil,:x])

    expect(ai.end_result(board)).to eq(:loss)
  end

  it 'knows if result is a draw' do
    board = Board.new([:x, :x, :o,
                       :o, :o, :x,
                       :x, :o, :x])

    expect(ai.end_result(board)).to eq(:draw)
  end

  context 'knows end score' do
    it 'if winner, returns win score' do
      board = Board.new([:x, :x, :x,
                         :o, :o, nil,
                        nil, nil, nil])

      expect(ai.negamax_score(board, :x, 1, 0)).to eq(10)
    end

    it 'if loser, returns loss score' do
      board = Board.new([:x, :x, nil,
                         :o, :o, :o,
                        nil, nil, :x])

      expect(ai.negamax_score(board, :x, 1, 0)).to eq(-10)
    end
  end

  context 'knows intermediate score:' do
    it 'if about to win, returns win score' do
      board = Board.new([:x, :x, nil,
                         :o, :o, nil,
                        nil, nil, nil])

      expect(ai.negamax_score(board, :x, 1, 0)).to eq(9)
    end

    it 'if about to win, returns win score' do
      board = Board.new([:x, :o,  :x,
                         :x, :x,  :o,
                         :o, :o, nil])

      expect(ai.negamax_score(board, :x, 1, 0)).to eq(9)
    end

    it 'if about to lose, returns loss score' do
      board = Board.new([:x, :x, nil,
                         :o, :o, nil,
                        nil, nil, :x])

      expect(ai.negamax_score(board, :o, -1, 0)).to eq(9)
    end
  end

  it 'plays into winning position' do
    board = Board.new([ :x, :o, nil,
                       nil, :o, nil,
                       :x, nil, nil ])

    expect(ai.pick_position(board)).to eq(3)
  end

  it 'plays into blocking position at a threat' do
    board = Board.new([ :x, :x, :o,
                       nil, :o, nil,
                       nil, nil, nil ])

    expect(ai.pick_position(board)).to eq(6)
  end

  it 'plays into blocking position at a threat' do
    board = Board.new([nil, nil, nil,
                       nil, :x, nil,
                       nil, :x, :o ])
    ai = AiNegamax.new(:o, :x)

    expect(ai.pick_position(board)).to eq(1)
  end

  it 'plays into blocking position at a threat' do
    board = Board.new([nil, :o, :o,
                       nil, nil, :x,
                       nil, nil, :x ])

    expect(ai.pick_position(board)).to eq(0)
  end

  it 'plays into blocking position at a threat' do
    board = Board.new([nil, nil, nil,
                       nil, :x, :x,
                       nil, nil, :o ])
    ai = AiNegamax.new(:o, :x)

    expect(ai.pick_position(board)).to eq(3)
  end

  it 'blocks' do
    board = Board.new([:o, nil, :x,
                       nil, :x, nil,
                       nil, nil, nil ])
    ai = AiNegamax.new(:o, :x)
    expect(ai.pick_position(board)).to eq(6)
  end

  it 'wins fast' do
    board = Board.new([ :o, :o, nil,
                        :x, :x, nil,
                       nil, nil, nil ])

    expect(ai.pick_position(board)).to eq(5)
  end

  it 'wins fast' do
    board = Board.new([ :o, nil, nil,
                        :x, :x, nil,
                       nil, :o, nil ])

    expect(ai.pick_position(board)).to eq(5)
  end
end
