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
  attr_reader :output, :input

  def initialize(output, input)
    @output = output
    @input  = input
  end

  def show(message)
    @output.puts(message)
  end

  def ask_for_position
    show('enter next move')
  end

  def capture_response
    @input.gets.chomp
  end
end

describe Ui do
  it 'displays messages' do
    ui = Ui.new(StringIO.new, StringIO.new)
    ui.show('hello')
    expect(ui.output.string).to eq("hello\n")
  end

  it 'asks user for the position' do
    ui = Ui.new(StringIO.new, StringIO.new)
    ui.ask_for_position
    expect(ui.output.string).to eq("enter next move\n")
  end

  it 'receives input from user' do
    ui = Ui.new(StringIO.new, StringIO.new('0'))
    ui.capture_response
    expect(ui.input.string).to eq('0')
  end
end

