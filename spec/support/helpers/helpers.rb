module BoardSetUpHelpers
  def add_moves(positions, mark)
    positions.each do |position|
      board.add_move(position, mark)
    end
  end

  def fill_up
    add_moves([0, 2, 5, 6, 7], :x)
    add_moves([1, 3, 4, 8], :o)
  end

  def make_win
    add_moves([0, 1, 2], :x)
    add_moves([3, 4], :o)
  end
end

module GameSetUpHelpers
  def game_setup(inputs = [])
    input  = StringIO.new(inputs.join("\n"))
    ui = FakeUi.new(input, StringIO.new)
    Game.new(board, ui, player_x, player_o)
  end
end
