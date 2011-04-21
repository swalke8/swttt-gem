class Board

  attr_reader :dimension, :game_board, :sum_of_row, :sum_of_column, :sum_of_left_diagonal, :sum_of_right_diagonal

  def initialize(dimension = 3)
    @dimension = dimension
    @sum_of_row = Array.new(@dimension) {0}
    @sum_of_column = Array.new(@dimension) {0}
    @sum_of_left_diagonal = 0
    @sum_of_right_diagonal = 0
    @game_board = Array.new(@dimension) {Array.new(@dimension) {0}}
  end

  def is_position_open?(row, column)
    return true if @game_board[row][column] == 0
    false
  end

  def set_value_at(row, column, new_value)
    @game_board[row][column] = new_value
    @sum_of_row[row] += new_value
    @sum_of_column[column] += new_value
    @sum_of_left_diagonal += new_value if row == column
    @sum_of_right_diagonal += new_value if @dimension - row - 1 == column
  end

end
