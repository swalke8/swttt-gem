class Board
  attr_reader :game_history, :dimension, :game_board, :player_value, :board,
              :sum_of_row, :sum_of_column, :left_diagonal, :right_diagonal

  def initialize(dimension = 3)
    @dimension = dimension
    @game_history, @board = [], [[0,0,0],[0,0,0],[0,0,0]]
    @sum_of_row, @sum_of_column = [0,0,0], [0,0,0]
    @left_diagonal, @right_diagonal = 0, 0
  end

  def move(row, column, value = nil)
    @board[row][column] = value || player_value
    update_sums(row, column, value || player_value)
    @game_history << Move.new(row, column, value || player_value)
  end

  def undo_move
    move = @game_history.pop
    update_sums(move.row, move.column, -player_value)
    @board[move.row][move.column] = 0
  end

  def number_of_moves_made
    @game_history.size
  end

  def is_empty_at?(row, column)
    @board[row][column].zero?
  end

  def full?
    @game_history.size == @dimension*@dimension
  end

  def player_value
    value = -(number_of_moves_made % 2)
    value = 1 if value.zero?
    return value
  end

  def print
    (0...@dimension).each { |row| print_row(row) }
  end

private

  def print_row(row)
    puts ""
    (0...@dimension).each { |column| print_square(row, column) }
  end

  def print_square(row, column)
    putc "["
    putc "X" if @board[row][column] == 1
    putc"O" if @board[row][column] == -1
    putc " " if @board[row][column].zero?
    putc "]"
  end

  def update_sums(row, column, update_value)
    @sum_of_row[row] += update_value
    @sum_of_column[column] += update_value
    @left_diagonal += update_value if row == column
    @right_diagonal += update_value if row == @dimension - column - 1
  end
end

class Move
  attr_reader :row, :column, :player_value

  def initialize(row,column, player_value = 1)
    @row, @column, @player_value = row, column, player_value
  end

  def ==(other)
    return other.is_a?(Move) && self.row == other.row && self.column == other.column
  end
end


