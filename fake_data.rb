class FakeData
  def initialize(bdata, num_rows)
    @oset = if bdata then 0 else 1 end
    @alphanum = [*'a'..'z', *'0'..'9']
    @num = [*'0'..'9']
    @special = [".", "<", ">", "/", "\\", "?", ";", "&", "%", "$", "@", "`", "(", ")", "*", ","]
    @month = bdata ? [*'0'..'30'] : [*'1'..'12']
    @day = bdata ? [*'0'..'50'] : [*'1'..'28']
    @year = bdata ? [*'1000'..'3000'] : [*'1980'..'2020']
    @hour = bdata ? [*'0'..'50'] : [*'0'..'23']
    @utcHour = bdata ? [*'0'..'50'] : [*'0'..'11']
    @minute = bdata ? [*'0'..'100'] : [*'0'..'59']
    @second = @minute
    @trend_data = RandomSineWave.new(num_rows, [*0..9].sample.to_f/10, [*1..5].sample)
  end

  def alphanumeric
    @alphanum.sample(rand(30) + @oset).join
  end

  def numeric
    @num.sample(rand(26) + @oset).join
  end

  def float
    @num.sample(rand(10) + @oset).join +
    "." + @num.sample(rand(6) + @oset).join
  end

  def date
    @month.sample + "-" + @day.sample + "-" + @year.sample
  end

  def time
    @hour.sample.rjust(2, '0') + ":" +
    @minute.sample.rjust(2, '0') + ":" +
    @second.sample.rjust(2, '0') + "-" +
    @utcHour.sample.rjust(2, '0') + ":" +
    @minute.sample.rjust(2, '0')
  end

  def datetime
    @year.sample + "-" +
    @month.sample.rjust(2, '0') + "-" +
    @day.sample.rjust(2, '0') + "T" +
    @hour.sample.rjust(2, '0') + ":" +
    @minute.sample.rjust(2, '0') + ":" +
    @second.sample.rjust(2, '0') + "-" +
    @utcHour.sample.rjust(2, '0') + ":" +
    @minute.sample.rjust(2, '0')
  end

  def special
    "\"" + @special.sample(rand(30) + @oset).join + "\""
  end

  def trend
    @trend_data.next
  end

  def unicode_character
    hex_string = "%04x" % (rand * 0xffff)
    [hex_string.hex].pack("U")
  end

  def unicode_string
    a = rand(8)
    u_str = ""
    8.times do
      u_str += unicode_character
    end
    u_str
  end

  def email
    alphanumeric + "@example.com"
  end
end
