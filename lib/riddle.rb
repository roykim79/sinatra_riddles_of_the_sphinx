class Riddle
  attr_reader(:details)

  def initialize(details)
    @details = details
  end

  def correct?(answer)
    @details[:a] == answer.downcase
  end
end
