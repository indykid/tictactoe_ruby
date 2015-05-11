def add_multiple_moves(mark, positions, board)
  positions.each do |position|
    board.add_move(position, mark)
  end
end

def fill_the_board(board)
  add_multiple_moves(:x, [0, 2, 5, 6, 7], board)
  add_multiple_moves(:o, [1, 3, 4, 8], board)
end
