# Create a csv with random data of preset types
# > make string of desired data type
# > shuffle the string to randomize it
# > chop up the string so it is the desired length of data
require './lib/support/fake_data'
require "optparse"

row = []
csv_array = []
col_types = []
data_types = ["special", "numeric", "datetime", "date", "time", "float", "sine_trend", "linear_trend", "one_hump_trend", "unicode", "email", "alphanumeric"]

num_rows = 20
num_cols = data_types.length
filename = 'default_name.csv'
valid_data = true

optparse = OptionParser.new do |opts|
  opts.banner = "Use switches to customize the output csv."

  opts.on("-r", "--rows [NUMROWS]", "Number of rows in CSV.") do |rows|
    num_rows = rows.to_i
  end

  opts.on("-c", "--columns [NUMCOLS]", "Number of columns in CSV.") do |cols|
    num_cols = cols.to_i
  end

  opts.on("-n", "--name [FILENAME]", "File name.") do |fname|
    filename = fname
  end

  opts.on("-v", "--valid_data", "Valid or invalid data.") do |v_data|
    valid_data = v_data
  end
end
optparse.parse!

csv = File.open("./CSV/#{filename}", "w" )

data = FakeData.new(valid_data: valid_data, num_rows: num_rows)

# Shuffle the column types
for i in 0..(num_cols - 1)
  col_types << data_types[i%data_types.length] + " " + i.to_s
end
col_types = col_types.shuffle
col_types << "index"

# Use the data type as the column headers
csv << col_types.join(",") + "\n"

puts "Creating CSV with #{num_rows} rows of columns of types:\n#{col_types.join(", ")}\n\n"

for i in 1..num_rows
  print "\rWriting row #{i}."

  for type in col_types
    # Make a shuffled string of the desired data
    case type
    when /alphanumeric/
      row << "\"" + data.alphanumeric + "\""
    when /datetime/
      row << "\"" + data.datetime + "\""
    when /numeric/
      row << data.numeric
    when /float/
      row << data.float
    when /date/
      row << "\"" + data.date + "\""
    when /time/
      row << data.time
    when /special/
      row << "\"" + data.special + "\""
    when /sine_trend/
      row << data.sine_trend
    when /linear_trend/
      row << data.linear_trend
    when /one_hump_trend/
      row << data.one_hump_trend
    when /index/
      row << i.to_s
    when /unicode/
      row << "\"" + data.unicode_string + "\""
    when /email/
      row << "\"" + data.email + "\""
    end
  end

  # Add the string to the file as a row of the csv
  csv << row.join(",") + "\n"
  row = []
end

csv.close

puts "\rThe file #{filename} has been written."
