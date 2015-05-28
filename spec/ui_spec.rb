require 'ui'

describe Ui do

  let(:output) { StringIO.new }

  xit 'greets' do
    ui = setup_ui

    ui.greet

    expect(output.string).to start_with(Ui::GREETING)
  end

  def setup_ui(inputs = [])
    input = StringIO.new(inputs.join("\n"))
    Ui.new(input, output)
  end
end
