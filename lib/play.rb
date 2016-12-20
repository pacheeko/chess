require_relative 'board'
require_relative 'moves'
require 'yaml'

include ChessMoves
include ChessBoard

class ChessPlay
  attr_reader :board, :current_player, :player1, :player2, :next_board

  def initialize
  	menu
  end

  def menu
  	puts "1. 1 Player Game\n2. 2 Player Game\n3. Load Game\n4. Delete Game\n5. Quit Game"
  	input = gets.chomp
  	case input
    when "1"
      setup_1_player
  	when "2"
  	  setup_2_player
  	when "3"
  	  load_game
  	when "4"
  	  delete_game
    when "5"
      puts "Thanks for playing!"
  	else
  	  puts "Invalid input"
  	  menu
  	end
  end

  def setup_1_player
    @board = create_board
    setup_board(@board)
    puts "Please enter your name."
    name = gets.chomp.capitalize
    @player1 = Player.new(name,WHITE_PIECES)
    @player2 = Player.new("AI",BLACK_PIECES)
    puts "\nWelcome #{player1.name}. You will use the white pieces and the AI will use the black pieces.\n"
    @current_player = @player1
    game_loop
  end

  def setup_2_player
  	@board = create_board
  	setup_board(@board)
  	puts "Please enter a name for player 1."
  	name = gets.chomp.capitalize
  	@player1 = Player.new(name,WHITE_PIECES)
  	puts "Please enter a name for player 2."
  	name = gets.chomp.capitalize
  	@player2 = Player.new(name,BLACK_PIECES)	
  	puts "\nWelcome #{player1.name} and #{player2.name}.\n#{player1.name} will have the white pieces and\n#{player2.name} will have the black pieces. \n#{player1.name} will go first.\n"
  	@current_player = @player1
  	game_loop
  end

  def game_loop
  	puts print_board(@board)
    if @current_player.name == "AI"
      puts "The AI moves."
      ai_game_loop
    else
    	puts "#{@current_player.name} please enter a move (ie. b1,c3) or type 'save' to save the game.\n"
    	input = gets.chomp.downcase.strip
    	input = input.split(",")
      if input[0] == "save"
        save_game
        menu
      elsif input.length != 2
        puts "That is an invalid move."
        game_loop
      else
      	start = input[0]
      	finish = input[1]
      	piece = convert_location(start)
      	piece = @board[piece[0]][piece[1]]
      	if @current_player.pieces.include?(piece)
      	  @next_board = Marshal.load(Marshal.dump(@board))
      	  move = move_piece(piece,start,finish,@next_board)
      	  if move
      	    game_end?
      	  else
      	    puts "That is an invalid move."
            game_loop
      	  end
      	else
      	  puts "That is not your piece to move!"
          game_loop
      	end
      end
    end
  end

  def ai_game_loop
    start = rand_square
    piece = @board[start[0]][start[1]]
    if @current_player.pieces.include?(piece)
      if can_move?(piece,start,@board)  
        move = false
        until move 
          finish = rand_square
          @next_board = Marshal.load(Marshal.dump(@board))
          move = move_piece(piece,start,finish,@next_board)
        end
        game_end?
      else
        ai_game_loop
      end
    else
      ai_game_loop
    end
  end

  def rand_square
    row = Random.new
    row = rand(8)
    square = Random.new
    square = rand(8)
    [row,square]
  end

  def game_end?
  	if @current_player.pieces.include?(BKING)
  	  current_king = BKING
  	  next_king = WKING
    else
  	  current_king = WKING
  	  next_king = BKING
  	end
    if check?(current_king,@next_board)
      puts "You cannot put yourself in check."
      game_loop
  	elsif check?(next_king,@next_board)
  	  if checkmate?(next_king,@next_board)
  	    @winner = @current_player
        finished
  	  else
  	  	@current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  	    puts "#{@current_player.name} you are in check." 
  	  	@board = @next_board
        game_loop
  	  end
  	elsif stalemate?(next_king,@next_board)
      puts print_board(@next_board)
      puts "Stalemate! It's a draw."
  	else
  	  @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  	  @board = @next_board
      game_loop
  	end
  end

  def finished
  	puts print_board(@next_board)
  	puts "Checkmate! #{@current_player.name} is the winner!"
  end

  def save_game
    yaml = YAML::dump(self)
    puts 'Please enter a save file name (no spaces).'
    save = gets.strip.split(" ")[0]
    save_file = File.new("saves/#{save}.yaml", 'w')
    File.write("saves/#{save}.yaml",yaml)
  end

  def load_game
    puts "Select a save file to load."
    saves = Dir.glob('saves/*')
    saves.each_with_index do |file,index|
      puts "#{index}. #{file}"
    end
    file_index = gets.chomp
    load_file = YAML::load(File.open(saves[file_index.to_i]))
    load_file.game_loop
  end

  def delete_game
    puts "Select a save file to delete."
    saves = Dir.glob('saves/*')
    saves.each_with_index do |file,index|
      puts "#{index}. #{file}"
    end
    file_index = gets.chomp
    puts "Are you sure you want to delete #{saves[file_index.to_i]}? (yes/no)"
    choice = gets.chomp.downcase
    if choice == "yes"
      File.delete(saves[file_index.to_i])
      puts "File deleted successfully!"
    elsif choice == "no"
      puts "No files deleted."
    else
      puts "Invalid input"
    end
    menu
  end
end

class Player
  attr_reader :name, :pieces

  def initialize(name,pieces)
  	@name = name
  	@pieces = pieces
  end
end

ChessPlay.new