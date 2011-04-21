class Board

  attr_reader :row, :column, :game_board, :sum_of_row, :sum_of_column, :sum_of_left_diagonal, :sum_of_right_diagonal

  def initialize(row = 3, column = 3)
    @row = row
    @sum_of_row = Array.new(@row) {0}
    @column = column
    @sum_of_column = Array.new(@column) {0}
    @sum_of_left_diagonal = 0
    @sum_of_right_diagonal = 0
    @game_board = Array.new(@row) {Array.new(@column) {0}}
  end

  def is_position_open?(row, column)
    return true if @game_board[row][column] == 0
    false
  end

  def set_value_at(row, column, new_value)
    @game_board[row][column] = new_value
    @sum_of_row[row] += new_value
    @sum_of_column[column] += new_value
  end

end
