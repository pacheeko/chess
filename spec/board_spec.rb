require 'board'
include ChessBoard

describe "ChessBoard" do
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

  describe '#setup_board' do
  	context "given a board" do
  	  it "returns the board to the game start state" do
  	  	expect(setup_board(empty_board)).to eql([[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
      		           							               [BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN,BPAWN],
    				   							                     [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
 					   							                       [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    				   							                     [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
    				   							                     [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
    				  							                     [WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN,WPAWN],
     				   							                     [WROOK,WKNIGHT,WBISHOP,WQUEEN,WKING,WBISHOP,WKNIGHT,WROOK]])
  	  end
  	end
  end

  describe '#check?' do
    context "given a board" do
      it "returns false if the king given is not in check" do
        expect(check?(WKING,board)).to eql(false)
      end
    end

    context "given a board where the black king is in check" do
      it "returns true" do
        board = [[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
                 [BPAWN,BPAWN,BPAWN,WQUEEN,BPAWN,WSQUARE,BPAWN,BPAWN],
                 [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                 [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                 [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                 [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                 [WPAWN,WPAWN,WPAWN,BSQUARE,WPAWN,WPAWN,WPAWN,WPAWN],
                 [WROOK,WKNIGHT,WBISHOP,WSQUARE,WKING,WBISHOP,WKNIGHT,WROOK]]
        expect(check?(BKING,board)).to eql(true)
      end
    end 
  end

  describe '#can_move?' do
    context "given a board" do
      it "returns true if the piece given can move" do
        expect(can_move?(WPAWN,"a2",board)).to eql(true)
      end
    end

    context "given a board" do
      it "returns false if the piece given cannot move" do
        expect(can_move?(WROOK,"h1",board)).to eql(false)
      end
    end
  end

  describe '#checkmate' do
    context "given a board" do
      it "returns false if the king given is not in checkmate" do
        board = [[BROOK,BKNIGHT,BBISHOP,BQUEEN,BKING,BBISHOP,BKNIGHT,BROOK],
                 [BPAWN,BPAWN,BPAWN,WQUEEN,BPAWN,BPAWN,BPAWN,BPAWN],
                 [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                 [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                 [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                 [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                 [WPAWN,WPAWN,WPAWN,BSQUARE,WPAWN,WPAWN,WPAWN,WPAWN],
                 [WROOK,WKNIGHT,WBISHOP,WSQUARE,WKING,WBISHOP,WKNIGHT,WROOK]]
        expect(checkmate?(BKING,board)).to eql(false)
      end
    end

    context "given a board" do
      it "returns true if the king give is in checkmate" do
        board = [[BROOK,BKNIGHT,BBISHOP,BQUEEN,WSQUARE,BBISHOP,BKNIGHT,BROOK],
                 [BPAWN,BPAWN,BPAWN,BPAWN,BKING,BPAWN,BPAWN,BPAWN],
                 [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                 [BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE],
                 [WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE,WSQUARE,BSQUARE],
                 [BSQUARE,WSQUARE,BSQUARE,WROOK,WQUEEN,WROOK,BSQUARE,WSQUARE],
                 [WPAWN,WPAWN,WPAWN,WPAWN,WSQUARE,WPAWN,WPAWN,WPAWN],
                 [BSQUARE,WKNIGHT,WBISHOP,WSQUARE,WKING,WBISHOP,WKNIGHT,WSQUARE]]
        expect(checkmate?(BKING,board)).to eql(true)
      end
    end
  end
end

