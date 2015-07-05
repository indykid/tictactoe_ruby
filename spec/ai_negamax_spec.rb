require 'ai_negamax'

describe AiNegamax do
  it 'returns winner score if result is a win' do
    ai = AiNegamax.new(:x, :o)

    expect(ai.end_score(:win)).to eq(10)
  end

  it 'returns loser score if result is a loss' do
    ai = AiNegamax.new(:x, :o)

    expect(ai.end_score(:loss)).to eq(-10)
  end

  it 'returns draw score if drawn' do
    ai = AiNegamax.new(:x, :o)

    expect(ai.end_score(:draw)).to eq(0)
  end

  it 'knows win result' do
    ai = AiNegamax.new(:x, :o)
    board = Board.new([:x, :x, :x,
                       :o, :o, nil,
                      nil, nil, nil])

    expect(ai.end_result(board)).to eq(:win)
  end

  it 'knows loss result' do
    ai = AiNegamax.new(:x, :o)
    board = Board.new([:x, :x, :o,
                       :o, :o, :x,
                       :o, nil,:x])

    expect(ai.end_result(board)).to eq(:loss)
  end

  it 'knows if result is a draw' do
    ai = AiNegamax.new(:x, :o)
    board = Board.new([:x, :x, :o,
                       :o, :o, :x,
                       :x, :o, :x])

    expect(ai.end_result(board)).to eq(:draw)
  end
end
