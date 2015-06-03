require 'spec_helper'
require 'board'
require 'game'
require 'support/doubles/fake_player.rb'

describe Game do

  let(:board) { Board.new }

  it 'is not over at the start' do
    game = game_setup

    expect(game.over?).to be(false)
  end

  it 'is over if won' do
    game = game_setup

    make_win

    expect(game.over?).to be(true)
  end

  it 'is over when drawn' do
    game = game_setup

    make_draw

    expect(game.over?).to be(true)
  end

  it 'adds player moves to the board' do
    ui = instance_double(Ui, get_move_from_user: 0).as_null_object
    game = game_setup(ui)

    game.play_turn

    expect(board.player_at(0)).to eq(:x)
  end

  it 'tracks player turns' do
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return(0, 1)
    game = game_setup(ui)

    2.times { game.play_turn }

    expect(board.player_at(1)).not_to eq(board.player_at(0))
  end

  it 'gets Ui to display the board' do
    ui = instance_double(Ui, get_move_from_user: 0).as_null_object
    game = game_setup(ui)

    game.play_turn

    expect(ui).to have_received(:display_board)
  end

  it 'gets Ui to alert on invalid move' do
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return('a', 1)
    game = game_setup(ui)

    game.play_turn

    expect(ui).to have_received(:alert)
  end

  it 'gets Ui to greet' do
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return(0, 3, 1, 4, 2)
    game = game_setup(ui)

    game.play

    expect(ui).to have_received(:greet)
  end

  it 'plays till win' do
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return(0, 3, 1, 4, 2)
    game = game_setup(ui)

    game.play

    expect(game.over?).to be(true)
  end

  it 'plays till draw' do
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return(0, 4, 2, 1, 7, 5, 3, 6, 8)
    game = game_setup(ui)

    game.play

    expect(game.over?).to be(true)
  end

  it 'gets ui to display board at the end' do
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return(0, 3, 1, 4, 2)
    game = game_setup(ui)

    game.play

    expect(ui).to have_received(:display_board).exactly(6).times
  end

  it 'gets Ui to display game over at the end' do
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return(0, 4, 2, 1, 7, 5, 3, 6, 8)
    game = game_setup(ui)

    game.play

    expect(ui).to have_received(:display_game_over)
  end

  it 'gets Ui to display winner at the end of the won game' do
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return(0, 3, 1, 4, 2)
    game = game_setup(ui)

    game.play

    expect(ui).to have_received(:display_winner)
  end

  it 'gets Ui to announce draw when drawn' do
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return(0, 4, 2, 1, 7, 5, 3, 6, 8)
    game = game_setup(ui)

    game.play

    expect(ui).to have_received(:display_draw)
  end

  def another_setup(inputs )
    ui = instance_double(Ui).as_null_object
    allow(ui).to receive(:get_move_from_user).and_return(inputs)
    player_x = FakePlayer.new(:x, ui) 
    player_o = FakePlayer.new(:o, ui)

    Game.new(board, ui, player_x, player_o)
  end

  def game_setup(ui = instance_double(Ui).as_null_object)
    player_x = FakePlayer.new(:x, ui) 
    player_o = FakePlayer.new(:o, ui)

    Game.new(board, ui, player_x, player_o)
  end
end
