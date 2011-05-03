require 'board'

class HumanPlayer
  def initialize(board)
    @game_board = board
  end

  def move(row, column)
    if @game_board.is_empty_at?(row, column)
      @game_board.move(row,column)
      return true
    end
    return false
  end
end
