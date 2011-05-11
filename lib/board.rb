class Board
  attr_reader :game_history, :player_value, :row_scores, :dimension,
              :column_scores, :left_diagonal_score, :right_diagonal_score

  def initialize(dimension = 3)
    @dimension = dimension
    @game_history, @board = [], Array.new(@dimension) {Array.new(@dimension) {0}}
    @row_scores, @column_scores = Array.new(@dimension) {0}, Array.new(@dimension) {0}
    @left_diagonal_score, @right_diagonal_score = 0, 0
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

  def value_at(row, column)
    @board[row][column]
  end

  def is_empty_at?(row, column)
    @board[row][column].zero?
  end

  def full?
    @game_history.size == @dimension*@dimension
  end

  def winning_value
    @dimension
  end

  def player_value
    value = -(number_of_moves_made % 2)
    value = 1 if value.zero?
    return value
  end

  def corner_occupied?
    corner_cells.each { |corner| return true if @game_history.include?(corner) }
    return false
  end

  def random_corner_cell
    corner_cells[rand(corner_cells.size)]
  end

private

  def corner_cells
    [Move.new(0,0),
     Move.new(0,@dimension-1),
     Move.new(@dimension-1,0),
     Move.new(@dimension-1, @dimension-1)]
  end

  def update_sums(row, column, update_value)
    @row_scores[row] += update_value
    @column_scores[column] += update_value
    @left_diagonal_score += update_value if row == column
    @right_diagonal_score += update_value if row == dimension - column - 1
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


