require 'board'
require 'moves'

include ChessMoves
include ChessBoard

describe 'ChessMoves' do  

  let (:empty_board) {[[WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                       [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                       [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                       [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                       [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                       [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                       [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                       [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE]]}

  let (:board) {setup_board(empty_board)}

  describe '#create_board' do
    it "returns creates an empty chess board" do
      expect(create_board).to eql(empty_board)
    end
  end

  describe '#move_piece' do
    context "given a piece, it's start location and end location" do
      it "moves the piece if the move is legal" do
      	expect(move_piece(WPAWN,"a2","a3",board)).to eql([[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
                              		           							[BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN],
                            				   							 		  [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                         					   							 		    [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                            				   							 		  [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                            				   							 		  [WPAWN,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                            				  							 		  [WSQUARE,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN],
                             				   							 		  [WROOK,WKNIGHT,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]])
      end
    end

    context "given a white pawn and a legal command to move it 2 spaces" do
      it "moves the pawn and returns the board" do
      	expect(move_piece(WPAWN,"d2","d4",board)).to eql([[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
      		           							 		                    [BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN],
    				   							 		                          [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
 					   							 		                            [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                            				   							 		  [WSQUARE,BSQUARE,WSQUARE,WPAWN,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                            				   							 		  [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                            				  							 		  [WPAWN,WPAWN,WPAWN,BSQUARE,WPAWN,WPAWN,WPAWN,WPAWN],
                             				   							 		  [WROOK,WKNIGHT,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]])
      end
    end

    context "given a white pawn and an illegal move" do
      it "returns false" do
      	expect(move_piece(WPAWN,"d2","d5",board)).to eql(false)
      end
    end

    context "given a white pawn and a move to take a black piece" do
      it "moves the pawn to the finish spot and removes the black piece from the board" do
      	board = [[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
      		       [BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN],
    		         [WSQUARE,BSQUARE,WSQUARE,WPAWN,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
 			           [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    			       [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
    		         [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    		         [WPAWN,WPAWN,WPAWN,BSQUARE,WPAWN,WPAWN,WPAWN,WPAWN],
     			       [WROOK,WKNIGHT,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]]
      	expect(move_piece(WPAWN,"d6","c7",board)).to eql([[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
      		     										                        [BPAWN,BPAWN,WPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN],
    		     										                          [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
 			  										                              [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    													                            [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
    		 										                              [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    		 										                              [WPAWN,WPAWN,WPAWN,BSQUARE,WPAWN,WPAWN,WPAWN,WPAWN],
     												   	                          [WROOK,WKNIGHT,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]])
      end
    end

    context "given a white knight and an illegal move" do
      it "returns false" do
        expect(move_piece(WKNIGHT,"b1","b3",board)).to eql(false)
      end
    end

    context "given a white knight and a legal move" do
      it "moves the knight and returns the updated board" do
        expect(move_piece(WKNIGHT,"b1","c3",board)).to eql([[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
                                                            [BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN],
                                                            [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                                                            [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                                                            [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                                                            [BSQUARE,WSQUARE,WKNIGHT,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                                                            [WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN],
                                                            [WROOK,WSQUARE,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]])
      end
    end

    context "given a black king and a legal move" do
      it "moves the king and returns the updated board" do       
        board = [[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
                 [BPAWN,BPAWN,BPAWN,WSQUARE,BPAWN,BPAWN,BPAWN,BPAWN],
                 [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                 [BSQUARE,WSQUARE,BSQUARE,BPAWN,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                 [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                 [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                 [WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN],
                 [WROOK,WKNIGHT,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]]
        expect(move_piece(BKING,"e8","d7",board)).to eql([[BROOK,BKNIGHT,BBISHOP,BQUEEN,WSQUARE,BBISHOP,BKNIGHT,BROOK],
                                                          [BPAWN,BPAWN,BPAWN,BKING,BPAWN,BPAWN,BPAWN,BPAWN],
                                                          [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                                                          [BSQUARE,WSQUARE,BSQUARE,BPAWN,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                                                          [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                                                          [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                                                          [WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN],
                                                          [WROOK,WKNIGHT,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]])
      end
    end

    context "given a black queen and an illegal move" do
      it "returns false" do
        expect(move_piece(BQUEEN,"d8","e8",board)).to eql(false)
      end
    end
  end

  describe '#move_white_pawn' do
  	context "given a command to move a white pawn 1 space" do
  	  it "determines if the move is valid, if it is it moves the piece and returns the board" do
  	  	expect(move_white_pawn(WPAWN,[6,0],[5,0],board)).to eql([[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
      		           							 		 		                       [BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN],
    				   							 		 		                             [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
 					   							 		 		                               [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    				   							 		 		                             [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
    				   							 		  		                           [WPAWN,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    				  							 		  		                           [WSQUARE,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN],
     				   							 		   	                             [WROOK,WKNIGHT,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]])
  	  end
  	end

  	context "given a command to move a pawn 2 spaces" do
  	  it "moves the piece if the move is valid" do
  	  	expect(move_white_pawn(WPAWN,[6,5],[4,5],board)).to eql([[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
      		           							 		 		                       [BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN],
    				   							 		 		                             [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
 					   							 		 		                               [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    				   							 		 		                             [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,WPAWN,WSQUARE,BSQUARE],
    				   							 		  		                           [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    				  							 		  		                           [WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,BSQUARE,WPAWN,WPAWN],
     				   							 		   	                             [WROOK,WKNIGHT,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]])
      end
    end
  end	
end
