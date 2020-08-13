# create a player class 
#   each player should have an empty array play_log
#   each player has  a unique play piece

# create a Node class that accepts x-y coordinates as an argument
#   check that new nodes are on an 8x8 board
#   run through the indexes of that column until a nil is reached
#     the node should be created just about that
#     It's siblings (adjacent positions) should be declared
# After each turn (node creation) check each primary direction of each node for four consecutive nodes
# if all 8 arrays on the board are full, declare the game a cat

# Prompt a player to select where to play
require 'pry'
class Player
  attr_accessor :play_log, :color

  def initialize(color)
    @play_log = []
    @name = gets.chomp.strip
    @color = color
  end

  def play_turn(board)
    puts "Where do you want to play?"
    column = gets.chomp.strip.to_i - 1
    spot = find_first_available(board, column)
    location = [spot, column]
    chip = Chip.new(color, location)
    board[spot][column] = chip.symbol
    # assign_network(chip, [spot, column], board)
    play_log << chip.dup
  end
  
  def find_first_available(board, column, counter = 0)
    return 7 if board[7][column] == 'x'
    play_turn if board[0][column] != 'x'
    current = board[counter][column]
    while current == 'x' && counter < 7
      counter += 1
      current = board[counter][column]
    end
    counter - 1
  end

  # def assign_network(chip, location, board)
  #   chip.top =   board[location[0] - 1][location[1]]
  #   chip.left =  board[location[0]][location[1] - 1]
  #   chip.right = board[location[0]][location[1] + 1]
  #   chip.tl =    board[location[0] - 1][location[1] - 1]
  #   chip.tr =    board[location[0] - 1][location[1] + 1]
  # end
end

class Chip < Player
  attr_accessor :symbol, :top, :left, :right, :tl, :tr, :location

  def initialize(symbol, location)
    @symbol = symbol
    @location = location
    @top = [location[0] - 1, location[1]]
    @left = [location[0], location[1] - 1]
    @right = [location[0], location[1] + 1]
    @tl = [location[0] - 1, location[1] - 1]
    @tr = [location[0] - 1, location[1] + 1]
  end
end


class Game < Player
  attr_accessor :board
  def initialize
    @board = make_board
    get_players
  end

  def get_players
    puts "Player 1 name"
    @player1 = Player.new('1')
    puts "Player 2 name"
    @player2 = Player.new('2')
  end

  def make_board
    hash = Hash.new
    for i in 0..7
      hash[i] = Array.new(8, 'x')
    end
    hash
  end

  def display_board
    board.each do |key, value|
      puts value.join('  ')
    end
  end

  def winner?(counter = 1, log, piece)
    return false if log.empty?
    log.each do |chip|
      directions = [chip.left, chip.right, chip.top, chip.tl, chip.tr]
      directions.each do |direction|
        until board[direction[0]][direction[1]] != piece
          chip = board[direction[0]][direction[1]]
          counter += 1
        end
        return true if counter >= 4
      end
    end
    false
  end

  def play_game
    until winner?(@player1.play_log, @player1.color) || winner?(@player2.play_log, @player2.color)
      display_board 
      @player1.play_turn(@board)
      display_board
      winner?(@player1.play_log, @player1.color)
      @player2.play_turn(@board)
      display_board
      winner?(@player2.play_log, @player2.color)
    end
  end
end

game = Game.new

game.play_game