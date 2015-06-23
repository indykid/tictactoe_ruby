require 'cli'

describe Cli do

  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:cli) { Cli.new(input, output) }

  it 'prints to output' do
    cli.show('a')

    expect(output.string).to include('a')
  end

  it 'receives user input' do
    input = StringIO.new('a')
    cli = Cli.new(input, output)

    expect(cli.get_input).to eq('a')
  end

  it 'makes input clean' do
    input = StringIO.new("a\n")
    cli = Cli.new(input, output)
  
    expect(cli.get_clean_input).to eq('a')
  end
end
