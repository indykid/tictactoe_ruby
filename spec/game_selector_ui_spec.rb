require 'game_selector_ui'

describe GameSelectorUi do

  let(:cli) { instance_double(Cli).as_null_object }
  let(:ui) { GameSelectorUi.new(cli) }

  it 'greets' do
    ui.greet
    
    expect(cli).to have_received(:show).with(GameSelectorUi::GREETING)
  end

end
