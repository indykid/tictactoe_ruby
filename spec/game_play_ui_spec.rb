require 'game_play_ui'
require 'board'

describe GamePlayUi do

  let(:cli) { instance_double(Cli).as_null_object }
  let(:ui) { GamePlayUi.new(cli) }

  it 'notifies about invalid input' do
    ui.notify_of_invalid_option

    expect(cli).to have_received(:show).with(GamePlayUi::INVALID_OPTION_NOTICE)
  end

  it 'asks user for move' do
    allow(cli).to receive(:get_input).and_return('0')
    ui.get_move_from_user(:x)

    expect(cli).to have_received(:show).with("Player x " + GamePlayUi::MOVE_REQUEST)
  end

  it 'shows user friendly 3x3 board' do
    board = Board.new([:x, nil, nil, nil, nil, nil, nil, nil, nil])
    ui.display_board(board)

    expect(cli).to have_received(:show).with(
      "  x |  2 |  3 \n--------------\n  4 |  5 |  6 \n--------------\n  7 |  8 |  9 \n"
    )
  end

  it 'shows user friendly 4x4 board' do
    board = Board.new([:x, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], 4)
    ui.display_board(board)

    expect(cli).to have_received(:show).with(
      "  x |  2 |  3 |  4 \n-------------------\n  5 |  6 |  7 |  8 \n-------------------\n  9 | 10 | 11 | 12 \n-------------------\n 13 | 14 | 15 | 16 \n"
    )
  end

  it 'displays winner' do
    ui.display_winner(:x)

    expect(cli).to have_received(:show).with(GamePlayUi::WINNER_ANNOUNCEMENT + 'x')
  end

  it 'display game over message' do
    ui.display_game_over

    expect(cli).to have_received(:show).with(GamePlayUi::GAME_OVER)
  end

  it 'displays game is drawn' do
    ui.display_draw
    expect(cli).to have_received(:show).with(GamePlayUi::GAME_DRAWN)
  end
end
