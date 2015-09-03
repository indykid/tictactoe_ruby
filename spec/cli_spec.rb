require 'cli'

describe Cli do
  let(:output) { StringIO.new }

  it 'prints to output' do
    input = StringIO.new
    cli = Cli.new(input, output)

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
