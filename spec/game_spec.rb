require 'spec_helper'
require 'board'
require 'game'
require 'support/doubles/fake_player.rb'
require 'support/doubles/fake_ui.rb'

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

    fill_up

    expect(game.over?).to be(true)
  end

  it 'places player moves on the board' do
    game = game_setup([0])

    game.play_turn

    expect(board.player_at(0)).to eq(:x)
  end

  it 'keeps track of player turns' do
    game = game_setup([0, 1])

    2.times { game.play_turn }

    expect(board.player_at(1)).to eq(:o)
  end

  it 'plays till win' do
    game = game_setup([0, 3, 1, 4, 2])

    game.play

    expect(game.over?).to be(true)
  end

  it 'plays till draw' do
    game = game_setup([0, 1, 2, 3, 5, 4, 6, 8, 7])

    game.play

    expect(game.over?).to be(true)
  end

  it 'will not error if non-numeric move given' do
    game = game_setup(['a', 0])

    expect { game.play_turn }.not_to raise_error
  end
end
