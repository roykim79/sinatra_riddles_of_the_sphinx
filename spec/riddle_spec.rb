require 'rspec'
require 'riddle'

describe Riddle do
  describe '#correct?' do
    it 'returns true if the riddle was answered correctly, or false' do
      riddles = [
        {
          :q => 'What is 1 + 1?',
          :a => '2'
        },
        {
          :q => 'What is 2 + 2?',
          :a => '4'
        },
        {
          :q => 'What is black and white and read all over',
          :a => 'Newspaper'
        }
      ]
      riddle1 = Riddle.new(riddles[0])
      expect(riddle1.correct?('2')).to eq(true)
      expect(riddle1.correct?('3')).to eq(false)
      riddle2 = Riddle.new(riddles[1])
      expect(riddle2.correct?('4')).to eq(true)
      expect(riddle2.correct?('3')).to eq(false)
      riddle3 = Riddle.new(riddles[2])
      expect(riddle3.correct?('Newspaper')).to eq(true)
      expect(riddle3.correct?('Dog')).to eq(false)
    end
  end
end
