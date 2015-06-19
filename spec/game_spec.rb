require 'spec_helper'
require 'board'
require 'game'

describe Game do

  let(:ui)       { instance_double(GamePlayUi).as_null_object }
  let(:board)    { Board.new }
  let(:player_x) { FakePlayer.new(:x) }
  let(:player_o) { FakePlayer.new(:o) }

  it 'is not over at the start' do
    game = setup_game_with_board
    expect(game.over?).to be(false)
  end

  it 'is over if won' do
    board = Board.new([:x, :x, :x, :o, :o, nil, nil, nil, nil])
    game = setup_game_with_board(board)

    expect(game.over?).to be(true)
  end

  it 'is over when drawn' do
    board = Board.new([:x, :x, :o, :o, :x, :o, :x, :o, :x])
    game = setup_game_with_board(board)

    expect(game.over?).to be(true)
  end

  it 'adds player moves to the board' do
    game = setup_game_with_players(FakePlayer.new(:x, [0]))

    game.play_turn

    expect(board.player_at(0)).to eq(:x)
  end

  it 'switches player turns' do
    game = setup_game_with_players(*setup_players([0], [1]))

    2.times { game.play_turn }

    expect(board.player_at(1)).not_to eq(board.player_at(0))
  end

  it 'gets Ui to display the board' do
    game = setup_game_with_players(FakePlayer.new(:x, [0]))

    game.play_turn

    expect(ui).to have_received(:display_board)
  end

  it 'gets Ui to alert on invalid move' do
    game = setup_game_with_players(FakePlayer.new(:x, ['a', 0]) )

    game.play_turn

    expect(ui).to have_received(:alert)
  end

  xit 'gets Ui to greet' do
    game = setup_for_win

    game.play

    expect(ui).to have_received(:greet)
  end

  it 'plays till win' do
    game = setup_for_win

    game.play

    expect(game.over?).to be(true)
  end

  it 'plays till draw' do
    game = setup_for_draw

    game.play

    expect(game.over?).to be(true)
  end

  it 'gets ui to display board at the end' do
    game = setup_for_win

    game.play

    expect(ui).to have_received(:display_board).exactly(6).times
  end

  it 'gets Ui to display game over at the end' do
    game = setup_for_draw

    game.play

    expect(ui).to have_received(:display_game_over)
  end

  it 'gets Ui to display winner at the end of the won game' do
    game = setup_for_win

    game.play

    expect(ui).to have_received(:display_winner)
  end

  it 'gets Ui to announce draw when drawn' do
    game = setup_for_draw

    game.play

    expect(ui).to have_received(:display_draw)
  end

  def setup_for_win
    player_x, player_o = setup_players([0, 1, 2], [3, 4])
    setup_game_with_players(player_x, player_o)
  end

  def setup_for_draw
    player_x, player_o = setup_players([0, 1, 4, 5, 6], [2, 3, 7, 8])
    setup_game_with_players(player_x, player_o)
  end

  def setup_game_with_players(player_x = player_x, player_o = player_o)
    Game.new(board, ui, player_x, player_o)
  end

  def setup_game_with_board(board = board)
    Game.new(board, ui, player_x, player_o)
  end

  def setup_players(x_moves, o_moves = [])
    [FakePlayer.new(:x, x_moves), FakePlayer.new(:o, o_moves)]
  end

  class FakePlayer
    attr_reader :moves, :mark
    def initialize(mark, moves = [])
      @mark = mark
      @moves = moves
    end

    def pick_position
      moves.shift
    end
  end
end
