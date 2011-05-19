class ABComputer
  def initialize

  end
  
  def make_move
    alpha = (-1.0)/(0.0)
    beta = (1.0)/(0.0)
    best_score = nil
    iterate_board do |row, column|
      @board.make_move(row, column)
      path_score = get_max(1, alpha, beta)
      @board.undo_move
      if best_score.nil? || path_score > best_score
        best_row = row
        best_column = column
        best_score = path_score
      end
    end
  end

  def get_max(depth, alpha, beta)
    iterate_board do |row, column|
      if alpha > beta
        return alpha
      else
        if @board.is_empty_at(row, column)
          @board.move(row, column)
          if @observer.game_over?
           return -@board.player_value if @observer.has_winner?
           return 0
          else
           value = get_min(depth+1, alpha, beta)
           alpha = value if alpha < value
          end
        end
      end
    end
  end

  def get_min(depth, alpha, beta)
    iterate_board do |row, column|
      if alpha < beta
        return beta
      else
        if @board.is_empty_at(row, column)
          @board.move(row, column)
          if @observer.game_over?
           return -@board.player_value if @observer.has_winner?
           return 0
          else
           value = get_max(depth+1, alpha, beta)
           beta = value if beta > value
          end
        end
      end
    end
  end

private

  def iterate_board
    (1..3).each { |row| (1..3).each { |column| yield(row, column) } }
  end
end
