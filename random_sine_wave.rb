# This class is from the stack overflow question
# http://stackoverflow.com/questions/28457047/how-can-i-generate-random-numbers-whose-average-follows-a-sine-wave-in-ruby
# answered by user maerics

class RandomSineWave
  attr_reader :size
  def initialize(size=20, variance=0.2)
    @size = size
    @step = 2 * Math::PI / size
    @position = 0
    @variance = variance
  end
  def next
    @position = 0 if @position >= 2 * Math::PI
    next_rand = Math.sin(@position) + (rand * @variance) - (@variance / 2)
    @position += @step
    next_rand
  end
end
