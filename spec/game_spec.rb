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

  it 'adds player moves to the board' do
    game = game_setup(FakeUi.new([0]))

    game.play_turn

    expect(board.player_at(0)).to eq(:x)
  end

  it 'tracks player turns' do
    game = game_setup(FakeUi.new([0, 1]))

    2.times { game.play_turn }

    expect(board.player_at(1)).not_to eq(board.player_at(0))
  end

  it 'gets Ui to display the board' do
    ui = FakeUi.new([0])
    game = game_setup(ui)

    game.play_turn

    expect(ui.board_display_count).to eq(1)
  end

  it 'gets Ui to alert on invalid move' do
    ui = FakeUi.new(['a', 1])
    game = game_setup(ui)

    game.play_turn

    expect(ui.alert_count).to eq(1)
  end

  it 'gets Ui to greet' do
    ui = FakeUi.new([0, 3, 1, 4, 2])
    game = game_setup(ui)

    game.play

    expect(ui.greet_count).to eq(1)
  end

  it 'plays till win' do
    game = game_setup(FakeUi.new([0, 3, 1, 4, 2]))

    game.play

    expect(game.over?).to be(true)
  end

  it 'plays till draw' do
    game = game_setup(FakeUi.new([0, 1, 2, 3, 4, 5, 6, 7, 8]))

    game.play

    expect(game.over?).to be(true)
  end

  xit 'will not error if non-numeric move given' do
    game = game_setup(FakeUi.new(['a', 1]))

    expect { game.play_turn }.not_to raise_error
  end

  xit 'does not error if invalid move given' do
    game = game_setup(FakeUi.new([10, 1]))

    expect { game.play_turn }.not_to raise_error
  end

  it 'gets ui to display board at the end' do
    ui = FakeUi.new([0, 3, 1, 4, 2])
    game = game_setup(ui)

    game.play

    expect(ui.board_display_count).to eq(6)
  end

  it 'gets Ui to display game over at the end' do
    ui = FakeUi.new([0, 4, 2, 1, 7, 5, 3, 6, 8])
    game = game_setup(ui)

    game.play

    expect(ui.game_over_count).to eq(1)
  end

  it 'gets Ui to display winner at the end of the won game' do
    ui = FakeUi.new([0, 3, 1, 4, 2])
    game = game_setup(ui)

    game.play

    expect(ui.winner_display_count).to eq(1)
  end

  it 'gets Ui to announce draw when drawn' do
    ui = FakeUi.new([0, 4, 2, 1, 7, 5, 3, 6, 8])
    game = game_setup(ui)

    game.play

    expect(ui.draw_display_count).to eq(1)
  end

  def game_setup(ui = FakeUi.new)
    player_x = FakePlayer.new(:x, ui) 
    player_o = FakePlayer.new(:o, ui)

    Game.new(board, ui, player_x, player_o)
  end
end
