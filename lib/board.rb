class Board

  attr_reader :dimension, :game_board, :sum_of_row, :sum_of_column, :sum_of_left_diagonal, :sum_of_right_diagonal

  def initialize(dimension = 3)
    @dimension = dimension
    @sum_of_row = Array.new(@dimension) {0}
    @sum_of_column = Array.new(@dimension) {0}
    @sum_of_left_diagonal = 0
    @sum_of_right_diagonal = 0
    @number_of_moves_made = 0
    @game_board = Array.new(@dimension) {Array.new(@dimension) {0}}
  end

  def is_position_open?(row, column)
    return true if @game_board[row][column] == 0
    false
  end

  def set_value_at(row, column, new_value)
    @game_board[row][column] = new_value
    update_sums(row, column, new_value)
    update_number_of_moves(new_value)
  end

  def full?
    @number_of_moves_made == @dimension*@dimension
  end

private

  def update_sums(row, column, value)
    value = -@game_board[row][column] if value == 0
    @sum_of_row[row] += value
    @sum_of_column[column] += value
    @sum_of_left_diagonal += value if row == column
    @sum_of_right_diagonal += value if @dimension - row - 1 == column
  end

  def update_number_of_moves(value)
    if value == 0
      @number_of_moves_made -= 1
    else
      @number_of_moves_made += 1
    end
  end
end
