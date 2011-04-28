class GameObserver
  
  def initialize(board)
    @game_board = board
  end

  def game_over?
    @game_board.full? || has_winner?
  end

  def has_winner?
    horizontal_win? || vertical_win? || diagonal_win?
  end

private

  def loop_array
    (0...@game_board.dimension).each { |index| return true if yield(index) == @game_board.dimension }
    false
  end

  def horizontal_win?
    loop_array { |row| @game_board.sum_of_row[row].abs }
  end

  def vertical_win?
    loop_array { |column| @game_board.sum_of_column[column].abs }
  end

  def diagonal_win?
    @game_board.left_diagonal.abs == @game_board.dimension || @game_board.right_diagonal.abs == @game_board.dimension
  end
end
