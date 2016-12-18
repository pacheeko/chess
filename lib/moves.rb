require_relative "board"
include ChessBoard

module ChessMoves
  
  def move_piece(piece,start,finish,board)
    start = convert_location(start)
    finish = convert_location(finish)
    return false if board[start[0]][start[1]] != piece
    return false if start == finish
    return false if not finish[0].between?(0,7) 
    return false if not finish[1].between?(0,7)
    case piece
    when WPAWN
      move_white_pawn(piece,start,finish,board)
    when BPAWN
      move_black_pawn(piece,start,finish,board)
    when WROOK,BROOK
      move_rook(piece,start,finish,board)
    when WKNIGHT,BKNIGHT
      move_knight(piece,start,finish,board)
    when WBISHOP,BBISHOP
      move_bishop(piece,start,finish,board)
    when WKING,BKING
      move_king(piece,start,finish,board)
    when WQUEEN,BQUEEN
      move_queen(piece,start,finish,board)
    else
      false
    end
  end

  def move_white_pawn(piece,start,finish,board)
    finish_space = board[finish[0]][finish[1]]
    if finish_space == WSQUARE || finish_space == BSQUARE
      if start[1] == finish[1]
        if finish[0] == start[0]-1
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        elsif finish[0] == start[0]-2 && start[0] == 6
          skipped = board[finish[0]][start[0]-1]
          if skipped == WSQUARE || skipped == BSQUARE
            return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
          end
        end
      end
    elsif BLACK_PIECES.include?(finish_space) 
      if finish[0] == start[0]-1
        if finish[1] == start[1]-1 || finish[1] == start[1]+1
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        end
      end
    end
    false
  end

  def move_black_pawn(piece,start,finish,board)
    finish_space = board[finish[0]][finish[1]]
    if finish_space == WSQUARE || finish_space == BSQUARE
      if start[1] == finish[1]
        if finish[0] == start[0]+1
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        elsif finish[0] == start[0]+2 && start[0] == 1
          skipped = board[finish[0]][start[0]+1]
          if skipped == WSQUARE || skipped == BSQUARE
            return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
          end
        end
      end
    elsif WHITE_PIECES.include?(finish_space) 
      if finish[0] == start[0]+1
        if finish[1] == start[1]+1 || finish[1] == start[1]-1
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        end
      end
    end
    false
  end

  def move_rook(piece,start,finish,board)
    finish_space = board[finish[0]][finish[1]]
    if straight_path_clear?(start,finish,board)
      if WHITE_PIECES.include?(piece)
        unless WHITE_PIECES.include?(finish_space)
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        end
      elsif BLACK_PIECES.include?(piece)
        unless BLACK_PIECES.include?(finish_space)
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        end
      end
    end
    false
  end

  def move_knight(piece,start,finish,board)
    finish_space = board[finish[0]][finish[1]]
    possible_moves = [[start[0]-1,start[1]-2],
                      [start[0]-2,start[1]-1],
                      [start[0]-1,start[1]+2],
                      [start[0]-2,start[1]+1],
                      [start[0]+1,start[1]+2],
                      [start[0]+1,start[1]-2],
                      [start[0]+2,start[1]-1],
                      [start[0]+2,start[1]+1]]     
    if possible_moves.include?(finish)
      if finish_space == WSQUARE || finish_space == BSQUARE
        return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
      elsif piece == WKNIGHT
        if BLACK_PIECES.include?(finish_space)
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        end
      elsif piece == BKNIGHT
        if WHITE_PIECES.include?(finish_space)
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        end
      end
    end
    false
  end

  def move_bishop(piece,start,finish,board)
    if start[0]-finish[0] == start[1]-finish[1] || start[0]-finish[0] == finish[1]-start[1]
      finish_space = board[finish[0]][finish[1]]
      if diagonal_path_clear?(start,finish,board)
        if WHITE_PIECES.include?(piece)
          unless WHITE_PIECES.include?(finish_space)
            return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
          end
        elsif BLACK_PIECES.include?(piece)
          unless BLACK_PIECES.include?(finish_space)
            return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
          end
        end
      end
    end
    false
  end

  def move_king(piece,start,finish,board)
    finish_space = board[finish[0]][finish[1]]
    possible_moves = [[start[0]-1,start[1]],
                      [start[0]-1,start[1]-1],
                      [start[0]-1,start[1]+1],
                      [start[0],start[1]+1],
                      [start[0],start[1]-1],
                      [start[0]+1,start[1]],
                      [start[0]+1,start[1]-1],
                      [start[0]+1,start[1]+1]]    
    if possible_moves.include?(finish)
      if finish_space == WSQUARE || finish_space == BSQUARE
        return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
      elsif piece == WKING
        if BLACK_PIECES.include?(finish_space)
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        end
      elsif piece == BKING
        if WHITE_PIECES.include?(finish_space)
          return place_piece(piece,board,start[0],start[1],finish[0],finish[1])
        end
      end
    end
    false
  end

  def move_queen(piece,start,finish,board)
    if start[0]-finish[0] == start[1]-finish[1] || start[0]-finish[0] == finish[1]-start[1]
      move_bishop(piece,start,finish,board)
    elsif start[0] == finish[0] || start[1] == finish[1]
      move_rook(piece,start,finish,board)
    else
      false
    end
  end

  private
  #helper functions

  def convert_location(loc)
    if loc.class == Array
      loc
    else
      loc = loc.split(//)
      letter = loc[0]
      loc[0] = 8-loc[1].to_i
      loc[1] = letter.ord - 97
      loc
    end
  end

  def place_piece(piece,board,start0,start1,finish0,finish1)
    board[finish0][finish1] = piece
    board = place_square(start0,start1,board)
  end

  def place_square(first,second,board)
    if first.even?
      if second.even?
        board[first][second] = WSQUARE
      else
        board[first][second] = BSQUARE
      end
    else
      if second.even?
        board[first][second] = BSQUARE
      else
        board[first][second] = WSQUARE
      end
    end
    board
  end

  def straight_path_clear?(start,finish,board)
    path = []
    if start[0] == finish[0]
      if start[1] > finish[1] #rook moves left
        current = [start[0],start[1]-1]
        until current == finish
          path << board[current[0]][current[1]]
          current[1] -= 1
        end
        return path.all? {|i| i == WSQUARE || i == BSQUARE}
      elsif start[1] < finish[1] #rook moves right
        current = [start[0],start[1]+1]
        until current == finish
          path << board[current[0]][current[1]]
          current[1] += 1
        end
        return path.all? {|i| i == WSQUARE || i == BSQUARE}
      end
    elsif start[1] == finish[1]
      if start[0] > finish[0] #rook moves up
        current = [start[0]-1,start[1]]
        until current == finish
          path << board[current[0]][current[1]]
          current[0] -= 1
        end
        return path.all? {|i| i == WSQUARE || i == BSQUARE}
      elsif start[0] < finish[0] #rook moves down
        current = [start[0]+1,start[1]]
        until current == finish
          path << board[current[0]][current[1]]
          current[0] += 1
        end
        return path.all? {|i| i == WSQUARE || i == BSQUARE}
      end
    end
    false
  end  

  def diagonal_path_clear?(start,finish,board)
    path = []
    if start[0] > finish[0] && start[1] < finish[1] #right-up
      current = [start[0]-1,start[1]+1]
      until current == finish
        path << board[current[0]][current[1]]
        current[0] -= 1
        current[1] += 1
      end
      return path.all? {|i| i == WSQUARE || i == BSQUARE}
    elsif start[0] > finish[0] && start[1] > finish[1] #left-up
      current = [start[0]-1,start[1]-1]
      until current == finish
        path << board[current[0]][current[1]]
        current[0] -= 1
        current[1] -= 1
      end
      return path.all? {|i| i == WSQUARE || i == BSQUARE}
    elsif start[0] < finish[0] && start[1] < finish[1] #right-down
      current = [start[0]+1,start[1]+1]
      until current == finish
        path << board[current[0]][current[1]]
        current[0] += 1
        current[1] += 1        
      end
      return path.all? {|i| i == WSQUARE || i == BSQUARE}
    elsif start[0] < finish[0] && start[1] > finish[1] #left-down
      current = [start[0]+1,start[1]-1]
      until current == finish
        path << board[current[0]][current[1]]
        current[0] += 1
        current[1] -= 1        
      end
      return path.all? {|i| i == WSQUARE || i == BSQUARE}      
    end
    false
  end
end