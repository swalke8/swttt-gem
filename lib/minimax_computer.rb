class MinimaxComputer

  def initialize(board, observer)
    @game_board = board
    @observer = observer
    @first_move = [Move.new(0,0),
                   Move.new(0,@game_board.dimension-1),
                   Move.new(@game_board.dimension-1,0),
                   Move.new(@game_board.dimension-1, @game_board.dimension-1)]
    @self_value = @game_board.player_value
  end

  def make_move(iteration = 0)
    return make_first_move if first_move?
    if @observer.game_over?
      if !iteration.zero?
        return -@game_board.player_value if @observer.has_winner?
        return 0
      end
    else
      perform_mini_max(iteration)
    end
  end

private

  def perform_mini_max(iteration)
    best_moves = BestMove.new(@game_board)
    for_each_cell do |row, column|
      path_value = 0
      if @game_board.is_empty_at?(row, column)
        path_value = path_score(row, column, iteration)
        best_moves.add_better_move(best_moves.value, path_value, Move.new(row, column), @self_value)
      end
    end
    return best_moves.value if !iteration.zero?
    move = best_moves.random
    @game_board.move(move.row, move.column) if !@observer.game_over?
  end

  def path_score(row, column, iteration)
    @game_board.move(row, column)
    path_value = make_move(iteration + 1)
    @game_board.undo_move
    return path_value
  end

  def for_each_cell
    (0...@game_board.dimension).each do |row|
      (0...@game_board.dimension).each do |column|
        yield(row, column)
      end
    end
  end

  def first_move?
    @game_board.number_of_moves_made < 2
  end

  def make_first_move
    if !@first_move.include?(@game_board.game_history.first)
      move = @first_move[rand(@first_move.size)]
    else
      middle = @game_board.dimension/2
      move = Move.new(middle, middle)
    end
    @game_board.move(move.row, move.column)
  end
end

class BestMove
  attr_accessor :moves, :value
  def initialize(game_board)
    @moves = []
    @value = nil
    @game_board = game_board
  end

  def random
    @moves[rand(@moves.size)]
  end

  def add_better_move(best_move, path_value, move, self_value)
    if better_or_equal_move?(best_move, path_value, self_value)
      @moves.clear if path_value !=  @value
      @value = path_value
      @moves << move
    end
  end

  def better_or_equal_move?(best_value, path_value, self_value)
    (best_value.nil?) or
    (path_value >= best_value && @game_board.player_value == self_value) or
    (path_value <= best_value && @game_board.player_value != self_value)
  end
end
