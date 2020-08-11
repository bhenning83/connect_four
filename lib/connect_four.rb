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



class Game
  attr_accessor :board
  def initialize
    @board = make_board
  end

  def make_board
    Array.new(8, Array.new(8, 'X'))
  end

  def display_board
    board.each do |ary|
      puts ary.join(' ')
    end
  end
end

game = Game.new
game.display_board