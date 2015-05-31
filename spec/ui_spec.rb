require 'ui'

describe Ui do

  let(:output) { StringIO.new }
  let(:input) { StringIO.new } 
  let(:ui) { Ui.new(input, output) }

  it 'greets' do
    ui.greet

    expect(output.string).to start_with(Ui::GREETING)
  end

  it 'alerts' do
    ui.alert

    expect(output.string).to start_with(Ui::ALERT)
  end

  it 'asks user for input' do
    input = StringIO.new("0")
    ui = Ui.new(input, output)

    ui.get_move_from_user

    expect(output.string).to start_with(Ui::MOVE_REQUEST)
  end

  it 'gets input for move from user' do
    input = StringIO.new("0")
    ui = Ui.new(input, output)

    ui.get_move_from_user

    expect(input.string).to eq('0')
  end

  it 'errors if non-numeric input' do

  end
end
