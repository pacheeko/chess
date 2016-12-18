require_relative 'board'
require_relative 'moves'
require 'yaml'

include ChessMoves
include ChessBoard

class ChessPlay
  attr_reader :board, :winner, :current_player, :player1, :player2, :next_board

  def initialize
  	menu
  end

  def menu
  	puts "1. New Game\n2. Load Game\n3. Delete Game\n4. Quit Game"
  	input = gets.chomp
  	case input
  	when "1"
  	  game_setup
  	when "2"
  	  load_game
  	when "3"
  	  delete_game
    when "4"
      puts "Thanks for playing!"
  	else
  	  puts "Invalid input"
  	  menu
  	end
  end

  def game_setup
  	@board = create_board
  	setup_board(@board)
  	@winner = false
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

  def game_end?
  	if @current_player.pieces.include?(BKING)
  	  current_king = BKING
  	  next_king = WKING
    else
  	  current_king = WKING
  	  next_king = BKING
  	end
  	if check?(next_king,@next_board)
  	  if checkmate?(next_king,@next_board)
  	    @winner = @current_player
        finished
  	  else
  	  	@current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  	    puts "#{@current_player.name} you are in check." 
  	  	@board = @next_board
        game_loop
  	  end
  	elsif check?(current_king,@next_board)
  	  puts "You cannot put yourself in check."
      game_loop
  	elsif stalemate?(next_king,@next_board)
      @winner = "noone"
      finished
  	else
  	  @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  	  @board = @next_board
      game_loop
  	end
  end

  def finished
  	puts print_board(@next_board)
  	if @winner.class == String
  	  puts "Stalemate! It's a draw."
  	else
  	  puts "Checkmate! #{@current_player.name} is the winner!"
  	end
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