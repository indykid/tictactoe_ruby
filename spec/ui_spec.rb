require 'ui'

describe Ui do
  class FakeInput
    def initialize(user_inputs)
      @user_inputs      = user_inputs
      @used_user_inputs = []
    end

    def gets
      used_user_input = user_inputs.shift
      @used_user_inputs << used_user_input
      used_user_input
    end

    def last_user_input
      used_user_inputs.last
    end

    private

    attr_reader :user_inputs, :used_user_inputs
  end

  class FakeOutput
    attr_reader :message

    def puts(string)
      @message = string 
    end
  end

  let(:output) {FakeOutput.new}

  def new_input(user_inputs=[])
    FakeInput.new(user_inputs)
  end

  it 'asks user for the position' do
    ui = Ui.new(output, new_input)
    ui.ask_for_position
    expect(output.message).to eq(Ui::PROMPT)
  end

  it 'receives input from user' do
    input = new_input(['0'])
    ui = Ui.new(nil, input)
    ui.take_input
    expect(input.last_user_input).to eq('0')
  end

  it 'does not allow non-number inputs' do
    #ui = Ui.new(StringIO.new, StringIO.new("a\n0"))
    ui = Ui.new(output, new_input(['a', '0']))
    expect(ui.take_numeric_input).to eq(0)
  end

  it 'alerts user about invalid non-number input' do
    ui = Ui.new(StringIO.new, StringIO.new("a\n0"))
    ui.take_numeric_input
    expect(ui.output.string.chomp).to end_with(Ui::ALERT)
  end

  it 'converts received position input into an integer' do
    ui = Ui.new(StringIO.new, StringIO.new('0'))
    expect(ui.capture_position).to eq(0)
  end

  it 'displays state of the board' do
    ui = Ui.new(StringIO.new, StringIO.new)
    board = Board.new
    board.add_move(0, :x)

    ui.visualise(board)

    expect(ui.output.string).to end_with("x 1 2\n3 4 5\n6 7 8\n")
  end
end


