require 'ai_negamax'

describe AiNegamax do
  let(:ai) { AiNegamax.new(:x, :o) }

  it 'returns winner score if result is a win' do
    expect(ai.end_score(:win)).to eq(10)
  end

  it 'returns loser score if result is a loss' do
    expect(ai.end_score(:loss)).to eq(-10)
  end

  it 'returns draw score if drawn' do
    expect(ai.end_score(:draw)).to eq(0)
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

      expect(ai.negamax_score(board, :x, 1)).to eq(10)
    end

    it 'if loser, returns loss score' do
      board = Board.new([:x, :x, :o,
                         :o, :o, :o,
                        nil, :x, :x])

      expect(ai.negamax_score(board, :x, 1)).to eq(-10)
    end
  end

  context 'knows intermediate score:' do
    it 'if about to win, returns win score' do
      board = Board.new([:x, :x, nil,
                         :o, :o, nil,
                        nil, nil, nil])

      expect(ai.negamax_score(board, ai.mark, 1)).to eq(10)
    end

    xit 'if about to lose, returns loss score' do
      board = Board.new([:x, :x, nil,
                         :o, :o, nil,
                        nil, nil, :x])

      expect(ai.negamax_score(board, :o, -1)).to eq(-10)
    end

    it 'scores intermediate board state based on the following end state' do
      board = Board.new([:x, :o,  :x,
                         :x, :x,  :o,
                         :o, :o, nil])

      expect(ai.negamax_score(board, :x, 1)).to eq(10)
    end
  end
end
