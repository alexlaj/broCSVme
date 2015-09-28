# The RandomSineWave class is from the stack overflow question
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

class LinearTrend
  def initialize(y_int = 0, slope = 5, variance = 2)
    @slope = slope
    @position = 0
    @y_int = y_int
    @variance = variance
    @scale = [1, 100, 1000, 10000].sample
    @sigfigs = rand(8)
  end

  def next
    next_step = ( @slope * @position + @y_int + [*-10..10].sample * @variance ) * @scale
    @position = @position + 1
    next_step
  end
end

class OneHumpTrend
  def initialize(variance = 0.2, y_int = 0, size)
    @position = 0
    @size = size
    @y_int = y_int
    @variance = variance
  end

  def next
    next_step = @position * @position + @y_int + @variance * @position * (rand(@position) - rand(@position))
    @position = @position + 1
    next_step
  end
end
