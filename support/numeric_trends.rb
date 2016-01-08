# The SineWaveTrend class is from the stack overflow question
# http://stackoverflow.com/questions/28457047/how-can-i-generate-random-numbers-whose-average-follows-a-sine-wave-in-ruby
# answered by user maerics

class SineWaveTrend
  attr_reader :size

  def initialize(size: 20, variance: 0.2, period: 1)
    @position = 0
    @size = size
    @variance = variance
    @step = period * 2 * Math::PI / size
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
  def initialize(size: 20, variance: 0.2, y_int: 0, slope: 5)
    @position = 0
    @size = size
    @variance = variance
    @y_int = y_int
    @slope = slope
    @scale = [100, 1000].sample
    @sigfigs = rand(8)
  end

  def next
    next_step = ( @slope * @position + @y_int ) * @scale
    next_step += [-1, 1].sample * next_step * @variance
    @position = @position + 1
    next_step
  end
end

class OneHumpTrend
  def initialize(size: 20, variance: 0.2, x_int: 0, y_int: 0)
    @position = 0
    @size = size
    @variance = variance
    @x_int = x_int
    @y_int = y_int * [-1, 1].sample
  end

  def next
    next_step = (@position - @x_int) * (@position - @x_int) + @y_int
    next_step += [-1, 1].sample * next_step * @variance
    @position = @position + 1
    next_step
  end
end
