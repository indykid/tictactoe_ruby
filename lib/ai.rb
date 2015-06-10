class Ai
  def initialize(mark)
    @mark = mark
  end

  def pick_position
  
  end

  def minimax(node, depth, maximizing)
    if depth == 1
      return value(node)
    end

    if maximizing
      best_value = -Float::INFINITY
      children(node).each do |child|
        value = minimax(child, depth - 1, !maximizing)
        best_value = max(best_value, val)
      end
      return best_value
    else
      best_value = Float::INFINITY
      children(node).each do |child|
        value = minimax(child, depth - 1, maximizing)
        best_value = min(best_value, value)
      end
      return best_value
    end
  end
end
