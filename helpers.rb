class FakeData
  def alphanumeric
    alphanumeric.sample(rand(30)+oset).join
  end

  def numeric
    numeric.sample(rand(26)+oset).join
  end

  def float
    numeric.sample(rand(10)+oset).join +
    "." + numeric.sample(rand(6)+oset).join
  end

  def date
    month.sample + "-" + day.sample + "-" + year.sample
  end

  def time
    hour.sample.rjust(2, '0') + ":" +
    minute.sample.rjust(2, '0') + ":" +
    second.sample.rjust(2, '0') + "-" +
    utcHour.sample.rjust(2, '0') + ":" +
    minute.sample.rjust(2, '0')
  end

  def datetime
    year.sample + "-" +
    month.sample.rjust(2, '0') + "-" +
    day.sample.rjust(2, '0') + "T" +
    hour.sample.rjust(2, '0') + ":" +
    minute.sample.rjust(2, '0') + ":" +
    second.sample.rjust(2, '0') + "-" +
    utcHour.sample.rjust(2, '0') + ":" +
    minute.sample.rjust(2, '0')
  end

  def special
    "\"" + special.sample(rand(30)+oset).join + "\""
  end

  def trend(i)
    trend_data[i-1]
  end
