require 'player'
describe Player do

  it 'gets move from user' do
    player = Player.new(:x)
    ui = FakeUi.new(StringIO.new('0'))
    expect(player.move(ui)).to eq(0)
   
  end
end

class FakeUi
  def initialize(input)
    @input = input
  end

  def ask_for_move
    @input.gets.chomp.to_i
  end
end

class Ui
  attr_reader :output

  def initialize(output)
    @output = output
  end

  def show(message)
    @output.puts(message)
  end
end

describe Ui do
  it 'displays messages' do
    ui = Ui.new(StringIO.new)
    ui.show('hello')
    expect(ui.output.string).to eq("hello\n")
  end
end

