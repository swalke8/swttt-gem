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

  def horizontal_win?
    check_for_winner { |row| @game_board.row_scores[row].abs }
  end

  def vertical_win?
    check_for_winner { |column| @game_board.column_scores[column].abs }
  end

  def diagonal_win?
    (is_a_win?(@game_board.left_diagonal_score.abs) ||
     is_a_win?(@game_board.right_diagonal_score.abs))
  end

  def check_for_winner
    (0..@game_board.dimension).each { |index| return true if is_a_win?(yield(index)) }
    false
  end

  def is_a_win?(value)
    value == @game_board.dimension+1
  end
end
