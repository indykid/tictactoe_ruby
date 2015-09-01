require 'game_selector_ui'
require 'cli'

describe GameSelectorUi do

  let(:cli) { instance_double(Cli).as_null_object }
  let(:ui) { GameSelectorUi.new(cli) }

  it 'greets' do
    ui.greet
    
    expect(cli).to have_received(:show).with(GameSelectorUi::GREETING)
  end

  it 'shows game size options' do
    ui.get_game_size

      expect(cli).to have_received(:show).with(GameSelectorUi::GAME_SIZE_OPTIONS)
  end

  it 'gets game size' do
    ui.get_game_size

    expect(cli).to have_received(:get_clean_input)
  end

  it 'shows game type options' do
    ui.get_game_type

    expect(cli).to have_received(:show).with(GameSelectorUi::GAME_TYPE_OPTIONS)
  end

  it 'gets game type' do
    ui.get_game_type

    expect(cli).to have_received(:get_clean_input)
  end

  it 'makes game' do
    allow(cli).to receive(:get_clean_input).and_return('')
    ui = described_class.new(cli)
    expect(ui.make_game).to be_instance_of(TictactoeCore::Game)
  end
end
