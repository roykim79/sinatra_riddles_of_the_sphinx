require 'rspec'
require 'riddle'

describe Riddle do
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
      :a => 'newspaper'
    }
  ]
  describe '#correct?' do
    it 'returns true if the riddle was answered correctly, otherwise it returns false' do
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

  describe '#details' do
    it 'returns the details of the riddle' do
      riddle = Riddle.new(riddles[0])
      expect(riddle.details()).to eq({
        :q => 'What is 1 + 1?',
        :a => '2'
      })
    end
  end
end
