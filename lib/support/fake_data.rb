require './lib/support/numeric_trends'

class FakeData
  def initialize(valid_data: true, num_rows: 20)
    @valid_data = valid_data
    @alphanum = [*'a'..'z', *'0'..'9']
    @num = [*'0'..'9']
    @special = [".", "<", ">", "/", "\\", "?", ";", "&", "%", "$", "@", "`", "(", ")", "*", ","]
    @month = [*'1'..'12']
    @day = [*'1'..'28']
    @year = [*'1980'..'2020']
    @hour = [*'0'..'23']
    @utcHour = [*'0'..'11']
    @minute = [*'0'..'59']
    @second = @minute
    @sine_data = SineWaveTrend.new(size: num_rows, variance: 0.2, period: [*1..5].sample)
    @linear_trend_data = LinearTrend.new(size: num_rows, variance: 0.2, y_int: [*-10..10].sample, slope: rand(num_rows))
    @one_hump_data = OneHumpTrend.new(size: num_rows, variance: 0.2, x_int: rand(num_rows), y_int: rand(num_rows))
    @boolean = ["True", "False", "Yes", "No"]
  end

  def alphanumeric
    @alphanum.sample(rand(30)).join
  end

  def numeric
    @num.sample(rand(20)).join
  end

  def float
    @num.sample(rand(16)).join +
    "." + @num.sample(rand(4)).join
  end

  def date
    @year.sample + "-" + @month.sample.rjust(2, '0') + "-" + @day.sample.rjust(2, '0')
  end

  def time
    @hour.sample.rjust(2, '0') + ":" +
    @minute.sample.rjust(2, '0') + ":" +
    @second.sample.rjust(2, '0')
  end

  def datetime
    date + ' ' + time + '-' +
    @utcHour.sample.rjust(2, '0') + ':' +
    @minute.sample.rjust(2, '0')
  end

  def special
    @special.sample(rand(30)).join
  end

  def sine_trend
    @sine_data.next
  end

  def linear_trend
    @linear_trend_data.next
  end

  def one_hump_trend
    @one_hump_data.next
  end

  def unicode_character
    hex_string = "%04x" % (rand * 0xffff)
    [hex_string.hex].pack("U")
  end

  def unicode_string
    a = rand(8)
    u_str = ""
    a.times { u_str += unicode_character }
    u_str
  end

  def email
    alphanumeric + "@example.com"
  end

  def boolean
    @boolean.sample
  end
end
