require 'game_selector_ui'

describe GameSelectorUi do

  let(:cli) { instance_double(Cli).as_null_object }
  let(:ui) { GameSelectorUi.new(cli) }

  it 'greets' do
    ui.greet
    
    expect(cli).to have_received(:show).with(GameSelectorUi::GREETING)
  end

  it 'shows game type options' do
    ui.get_game_type

    expect(cli).to have_received(:show).with(GameSelectorUi::GAME_TYPE_OPTIONS)
  end

  it 'gets game type' do
    ui.get_game_type

    expect(cli).to have_received(:get_clean_input)
  end

end
