require './lib/connect_four.rb'
describe Player do
  describe "#play_turn" do
    it "creates a node at the first availble spot in the column" do
      player = Player.new
      node = Node.new(7, 1)
      player.play_turn(7).to eql(node)
    end

    it "creates a node at the first availble spot in the column" do
      player = Player.new
      combined_play_log = [Node.new(7, 1), Node.new(7, 2)]
      node = Node.new(7, 3)
      player.play_turn(7).to eql(node)
    end
  end
end

describe Game do
  describe "#make_board" do
    it "creates a hash of 8 arrays" do
      game = Game.new
      game.make_board
      expect(board.length).to eql(8)
    end

    it "rows 1-8 should be an array of 8 X's" do
      game = Game.new
      game.make_board
      combined_play_log = []
      row = Array.new(8, "X")
      expect(board[1]).to eql(row)
    end
  end

  describe "#display_board" do
    it "accurately displays where a player played" do
      game = Game.new
      game.make_board
      game.display_board
      combined_play_log = []
      row = Array.new(9, nil)
      expect(board[1]).to eql()
    end
  end
end