# Create a csv with random data of preset types
# > make string of desired data type
# > shuffle the string to randomize it
# > chop up the string so it is the desired length of data

require "optparse"

row = []
csv_array = []
col_types = []
data_types = ["special", "alphanumeric", "numeric", "float", "datetime", "time"]

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Use switches to customize the output csv."

  opts.on("-r", "--rows [NUMROWS]", "Number of rows in CSV.") do |rows|
    options[:rows] = rows.to_i
  end

  opts.on("-c", "--columns [NUMCOLS]", "Number of columns in CSV.") do |cols|
    options[:columns] = cols.to_i
  end

  opts.on("-n", "--name [FILENAME]", "File name.") do |fname|
    options[:filename] = fname
  end

  opts.on("-b", "--baddaata", "Allow bad data.") do |bdata|
    options[:baddata] = bdata
  end
end

optparse.parse!

options[:baddata] |= false

output_file = options[:filename]
output_file ||= "default_name.csv"
csv = File.open(output_file, "w" )

num_rows = options[:rows]
num_rows ||= 20
num_cols = options[:columns]
num_cols ||= data_types.length

# oset = options[:baddaata] ? 1 : 0 # Offset for sample(rand()) calls, let 0 be valid for bad data.
oset = if options[:baddata] then 0 else 1 end
alphanumeric = [*'a'..'z', *'0'..'9']
numeric = [*'0'..'9']
special = [".", "<", ">", "/", "\\", "?", ";", "&", "%", "$", "@", "`", "(", ")", "*"]
month = options[:baddaata] ? [*'0'..'30'] : [*'1'..'12']
day = options[:baddata] ? [*'0'..'50'] : [*'1'..'28']
year = options[:baddata] ? [*'1000'..'3000'] : [*'1980'..'2020']
hour = options[:baddata] ? [*'0'..'50'] : [*'0'..'23']
utcHour = options[:baddata] ? [*'0'..'50'] : [*'0'..'11']
minute = options[:baddata] ? [*'0'..'100'] : [*'0'..'59']
second = minute

# Shuffle the column types
for i in 0..(num_cols-1)
  col_types << data_types[i%data_types.length]
end
col_types = col_types.shuffle

# Use the data type as the column headers
csv << col_types.join(",") + "\n"

puts "Creating CSV with #{num_rows} rows of columns of type:\n#{col_types}"

for i in 1..num_rows
  print "\rWriting row #{i}."

  for type in col_types
    # Make a shuffled string of the desired data
    if type == "alphanumeric"
      row << alphanumeric.sample(rand(30)+oset).join
    elsif type == "numeric"
      row << numeric.sample(rand(26)+oset).join
    elsif type == "float"
      row << numeric.sample(rand(10)+oset).join +
        "." + numeric.sample(rand(6)+oset).join
    elsif type == "date"
      row << month.sample + "-" + day.sample + "-" + year.sample
    elsif type == "time"
      row << hour.sample.rjust(2, '0') + ":" +
        minute.sample.rjust(2, '0') + ":" +
        second.sample.rjust(2, '0') + "-" +
        utcHour.sample.rjust(2, '0') + ":" +
        minute.sample.rjust(2, '0')
    elsif type == "datetime"
      row << year.sample + "-" +
        month.sample.rjust(2, '0') + "-" +
        day.sample.rjust(2, '0') + "T" +
        hour.sample.rjust(2, '0') + ":" +
        minute.sample.rjust(2, '0') + ":" +
        second.sample.rjust(2, '0') + "-" +
        utcHour.sample.rjust(2, '0') + ":" +
        minute.sample.rjust(2, '0')
    elsif type == "special"
      row << "\"" + special.sample(rand(30)+oset).join + "\""
    end
  end

  # Add the string to the file as a row of the csv
  csv << row.join(",") + "\n"
  row = []
end

csv.close

puts "\rThe file #{output_file} has been written."
