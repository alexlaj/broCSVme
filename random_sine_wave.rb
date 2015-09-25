# This class is from the stack overflow question
# http://stackoverflow.com/questions/28457047/how-can-i-generate-random-numbers-whose-average-follows-a-sine-wave-in-ruby
# answered by user maerics

class RandomSineWave
  attr_reader :size

  def initialize(size = 20, variance = 0.2, period = 1)
    @size = size
    @step = period * 2 * Math::PI / size
    @position = 0
    @variance = variance
    @scale = [100, 1000, 10000].sample
    @sigfigs = rand(8)
  end

  def next
    @position = 0 if @position >= 2 * Math::PI
    next_rand = ( ( Math.sin(@position) + (rand * @variance) - (@variance / 2) ) * @scale ).round(@sigfigs)
    @position += @step
    next_rand
  end
end
