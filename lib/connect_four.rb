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

class Player
end

class Chip
  def initialize(symbol, location)
    @symbol = symbol
    @top = top
    @left = left
  end
end


class Game
  attr_accessor :board
  def initialize
    @board = make_board
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
      puts value.join(' ')
    end
  end
end

game = Game.new
p game.board

game.board[3][1] = 'O'
game.display_board