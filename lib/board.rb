module ChessBoard
  
  BPAWN = "♙"
  BKNIGHT = "♘"
  BBISHOP = "♗"
  BROOK = "♖"
  BQUEEN = "♕"
  BKING = "♔"
  WPAWN = "♟"
  WKNIGHT = "♞"
  WBISHOP = "♝"
  WROOK = "♜"
  WQUEEN = "♛"
  WKING = "♚"
  BSQUARE = "□"
  WSQUARE = "■"
  BLACK_PIECES = [BPAWN,BKNIGHT,BBISHOP,BROOK,BKING,BQUEEN]
  WHITE_PIECES = [WPAWN,WKNIGHT,WBISHOP,WROOK,WKING,WQUEEN]

  def create_board
    board = []
    4.times do 
      row1 = [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE]
      row2 = [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE]
      board << row1
      board << row2
    end
    board
  end

  def print_board(board)
    board_strings = []
    n = 8
    board.each do |row|
      str = "#{n}"
      row.each do |square|
        str += "\s#{square}"
      end
      str += "\n"
      board_strings << str
      n -= 1
    end
    board_strings << "\s\sa\sb\sc\sd\se\sf\sg\sh\n"
  end

  def setup_board(board)
    board[0][0] = BROOK
    board[0][1] = BKNIGHT
    board[0][2] = BBISHOP
    board[0][3] = BQUEEN
    board[0][4] = BKING
    board[0][5] = BBISHOP
    board[0][6] = BKNIGHT
    board[0][7] = BROOK
    board[7][0] = WROOK
    board[7][1] = WKNIGHT
    board[7][2] = WBISHOP
    board[7][3] = WQUEEN
    board[7][4] = WKING
    board[7][5] = WBISHOP
    board[7][6] = WKNIGHT
    board[7][7] = WROOK
    board[1].map! do |i|
      i = BPAWN
    end
    board[6].map! do |i|
      i = WPAWN
    end
    board
  end

  def check?(king,board)
    king_square = find_piece(king,board)
    if king == BKING
      to_test = WHITE_PIECES
    elsif king == WKING
      to_test = BLACK_PIECES
    else
      return false
    end
    new_board = Marshal.load(Marshal.dump(board))
    new_board.each_with_index do |row,index1|
      row.each_with_index do |piece,index2|
        if to_test.include?(piece)
          start = [index1,index2]
          if move_piece(piece,start,king_square,new_board)
            return true
          end
        end
      end
    end
    false
  end

  def checkmate?(king,board)
    if king == BKING
      to_test = BLACK_PIECES
    elsif king == WKING
      to_test = WHITE_PIECES
    else
      return nil
    end
    board.each_with_index do |row,index0|
      row.each_with_index do |piece,index1|
        if to_test.include?(piece)
          start = [index0,index1]
            if can_stop_checkmate?(king,piece,start,board)
              return false
            end
        end
      end
    end
    true
  end

  def stalemate?(king,board)
  	if king == BKING
  	  to_test = BLACK_PIECES
  	elsif king == WKING
  	  to_test = WHITE_PIECES
  	else
  	  nil
  	end
    if check?(king,board)
      return false
    else
  	  new_board = Marshal.load(Marshal.dump(board))
  	  new_board.each_with_index do |row,index0|
  	    row.each_with_index do |piece,index1|
  	      if to_test.include?(piece)
  	  	    start = [index0,index1]
  	  	    if can_stop_checkmate?(king,piece,start,new_board)
  	  	      return false
  	  	  	end
  	  	  end
  	  	end
  	  end
  	  true
  	end
  end

  def find_piece(piece,board)
    board.each_with_index do |row,index0|
      index1 = row.index(piece)
      if index1 != nil
        return [index0,index1]
      end
    end
  end

  def can_move?(piece,start,board)
  	new_board = Marshal.load(Marshal.dump(board))
  	new_board.each_with_index do |row,index0|
  	  row.each_with_index do |item,index1|
  	  	finish = [index0,index1]
  	  	if move_piece(piece,start,finish,new_board)
  	  	  return true
  	  	end
  	  end
  	end
  	false
  end

  def can_stop_checkmate?(king,piece,start,board) 
    board.each_with_index do |row,index0|
      row.each_with_index do |item,index1|
        new_board = Marshal.load(Marshal.dump(board))
      	finish = [index0,index1]
      	  if move_piece(piece,start,finish,new_board)
      	  	if not check?(king,new_board)
      	  	  return true
      	  	end
      	  end
      	end
      end
    false
  end
end

