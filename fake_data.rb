class FakeData
  def initialize(bdata, num_rows)
    @oset = if bdata then 0 else 1 end
    @alphanumeric = [*'a'..'z', *'0'..'9']
    @numeric = [*'0'..'9']
    @special = [".", "<", ">", "/", "\\", "?", ";", "&", "%", "$", "@", "`", "(", ")", "*", ","]
    @month = bdata ? [*'0'..'30'] : [*'1'..'12']
    @day = bdata ? [*'0'..'50'] : [*'1'..'28']
    @year = bdata ? [*'1000'..'3000'] : [*'1980'..'2020']
    @hour = bdata ? [*'0'..'50'] : [*'0'..'23']
    @utcHour = bdata ? [*'0'..'50'] : [*'0'..'11']
    @minute = bdata ? [*'0'..'100'] : [*'0'..'59']
    @second = @minute
    @trend_data = RandomSineWave.new(num_rows, [*0..9].sample.to_f/10)
  end

  def alphanumeric
    @alphanumeric.sample(rand(30) + @oset).join
  end

  def numeric
    @numeric.sample(rand(26) + @oset).join
  end

  def float
    @numeric.sample(rand(10) + @oset).join +
    "." + @numeric.sample(rand(6) + @oset).join
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

  def trend(i)
    @trend_data.next
  end
end
