require './lib/connect_four.rb'

describe Player do
  before(:each) do
    @player = Player.new('black')
    @game = Game.new
    @board = @game.make_board
  end
  context '#valid?' do
    it 'returns false if input us nil' do
      expect(@player.valid?(nil)).to be(false)
    end

    it 'returns true if input is between 0 and 8' do
      expect(@player.valid?(4)).to be(true)
    end

    it 'returns false if input is greater than 7' do
      expect(@player.valid?(8)).to be(false)
    end
  end

  context '#find_first_available' do
    it 'returns 7 if the column is empty' do
      column = 5
      expect(@player.find_first_available(@board, column)).to eql(7)
    end
  end
end