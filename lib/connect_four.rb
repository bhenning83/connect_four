#creates players for the game
class Player
  attr_accessor :play_log, :color, :name

  def initialize(color)
    @play_log = []
    @name = gets.chomp.strip
    @color = color
  end

  def play_turn(board)
    puts "#{name}, where do you want to play?"
    column = gets.chomp.strip.to_i - 1 until valid?(column)
    spot = find_first_available(board, column)
    return if spot.nil?
    location = [spot, column]
    chip = Chip.new(color, location, board)
    board[spot][column] = chip.dup
    play_log << chip.dup
  end

  def valid?(num)
    return false if num.nil?
    
    num >= 0 && num < 8
  end

  def find_first_available(board, column, counter = 0)
    return 7 if board[7][column] == '◯   ' #if column is empty

    if board[0][column] != '◯   ' #prevents play above top row
      play_turn(board)
      return nil
    end

    current = board[counter][column]
    while current == '◯   ' && counter < 7 #traverses downward until a spot isn't empty
      counter += 1
      current = board[counter][column]
    end
    counter - 1
  end
end

#marks where player played
class Chip
  attr_accessor :symbol, :location, :board

  def initialize(symbol, location, board)
    @symbol = symbol
    @location = location
    @board = board
  end

  def top
    return nil if location[0] == 0
    board[location[0] - 1][location[1]]
  end

  def left
    return nil if location[1] == 0
    board[location[0]][location[1] - 1]
  end

  def right
    return nil if location[1] == 7
    board[location[0]][location[1] + 1]
  end

  def tl
    return nil if location[0] == 0

    board[location[0] - 1][location[1] - 1]
  end

  def tr
    return nil if location[0] == 0
    board[location[0] - 1][location[1] + 1]
  end
end

#core methods for the game
class Game < Player
  attr_accessor :board
  def initialize
    @board = make_board
    get_players
  end

  def get_players
    puts 'Player 1 name'
    @player1 = Player.new('⚪')
    puts 'Player 2 name'
    @player2 = Player.new('⚫')
  end

  def make_board
    hash = {}
    (0..7).each do |i|
      hash[i] = Array.new(8, '◯   ')
    end
    hash
  end

  def display_board
    puts "\n\n1   2   3   4   5   6   7   8"
    board.each do |_key, value|
      puts
      value.each do |chip|
        chip == '◯   ' ? (print chip) : (print chip.symbol + '  ')
      end
      puts
    end
    puts
  end

  def winner?(log, piece) #checks each direciton on every chip for 4 straight 
    return false if log.empty?

    log.each do |chip|
      directions = %w[left right top tl tr]
      directions.each do |direction|
        counter = 1
        current = chip.send(direction.to_sym)
        next if current.nil?

        until current == '◯   ' || current.nil? || current.symbol != piece
          current = current.send(direction.to_sym)
          counter += 1
        end
        return true if counter >= 4
      end
    end
    false
  end

  def play_game
    64.times do #total spaces on the board
      display_board
      @player1.play_turn(@board)
      display_board
      if winner?(@player1.play_log, @player1.color)
        winner_message(@player1)
        break
      end
      @player2.play_turn(@board)
      display_board
      if winner?(@player2.play_log, @player2.color)
        winner_message(@player2)
        break
      end
    end
    puts "Cat game."
  end

  def winner_message(player)
    puts "#{player.name} wins!"
    exit
  end
end



game = Game.new
game.play_game
