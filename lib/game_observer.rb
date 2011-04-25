class GameObserver
  
  def initialize(board)
    @game_board = board
  end

  def winner?
    horizontal_win? || vertical_win? || diagonal_win?
  end

private

  def horizontal_win?
    check_for_win { |row| @game_board.sum_of_row[row].abs }
  end

  def vertical_win?
    check_for_win { |column| @game_board.sum_of_column[column].abs } 
  end

  def diagonal_win?
    return true if @game_board.sum_of_left_diagonal.abs == @game_board.dimension
    return true if @game_board.sum_of_right_diagonal.abs == @game_board.dimension
    false
  end

  def check_for_win
    (0...@game_board.dimension).each do |row_or_column|
      return true if yield(row_or_column) == @game_board.dimension
    end
    false
  end
end
