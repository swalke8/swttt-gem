class MinimaxComputer

  def initialize(board, observer)
    @game_board, @observer = board, observer
    @first_move = [Move.new(0,0),
                   Move.new(0,@game_board.dimension-1),
                   Move.new(@game_board.dimension-1,0),
                   Move.new(@game_board.dimension-1, @game_board.dimension-1)]
    @my_player_value = @game_board.player_value
  end

  def move(iteration = 0)
    if first_move?
      move = first_move
      return @game_board.move(move.row, move.column)
    end
    return path_score_result if @observer.game_over?
    mini_max(iteration)
  end

private

  def first_move?
    @game_board.number_of_moves_made < 2
  end

  def first_move
    if !@first_move.include?(@game_board.game_history.first)
      move = @first_move[rand(@first_move.size)]
    else
      middle = @game_board.dimension/2
      move = Move.new(middle, middle)
    end
  end

  def path_score_result
    return -@game_board.player_value if @observer.has_winner?
    return 0
  end

  def mini_max(iteration)
    best_moves = BestMove.new(@game_board, @my_player_value)
    for_each_cell { |row, column| best_moves.add_better_move(best_moves.value, path_score(row, column,iteration),
                                  Move.new(row, column)) if @game_board.is_empty_at?(row, column) }
    return best_moves.value if !iteration.zero?
    move = best_moves.random
    @game_board.move(move.row, move.column) if !@observer.game_over?
  end

   def for_each_cell
    (0...@game_board.dimension).each do |row|
      (0...@game_board.dimension).each { |column| yield(row, column) }
    end
  end

  def path_score(row, column, iteration)
    @game_board.move(row, column)
    score = move(iteration + 1)
    @game_board.undo_move
    return score
  end
 end

class BestMove
  attr_accessor :moves, :value
  def initialize(game_board, my_player_value)
    @moves = []
    @value = nil
    @game_board, @my_player_value = game_board, my_player_value
  end

  def random
    @moves[rand(@moves.size)]
  end

  def add_better_move(best_score, path_score, move)
    if better_or_equal_move?(best_score, path_score)
      @moves.clear and @value = path_score if path_score !=  @value
      @moves << move
    end
  end

  def better_or_equal_move?(best_score, path_score)
    (best_score.nil?) or
    (path_score >= best_score && @game_board.player_value == @my_player_value) or
    (path_score <= best_score && @game_board.player_value != @my_player_value)
  end
end
