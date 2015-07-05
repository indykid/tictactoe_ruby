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

  context 'knows intermediate score' do
    it 'if about to win, returns win score' do
      board = Board.new([:x, :x, nil,
                         :o, :o, nil,
                        nil, nil, nil])
      
      expect(ai.negamax_score(board, ai.mark, 1)).to eq(10)
    end
  end
end
