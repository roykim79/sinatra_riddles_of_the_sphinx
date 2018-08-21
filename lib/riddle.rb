class Riddle
  def initialize(details)
    @details = details
  end

  def correct?(answer)
    @details[:a] == answer
  end
end
