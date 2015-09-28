# Create a csv with random data of preset types
# > make string of desired data type
# > shuffle the string to randomize it
# > chop up the string so it is the desired length of data
require './fake_data'
require './random_sine_wave'
require "optparse"

row = []
csv_array = []
col_types = []
data_types = ["special", "alphanumeric", "numeric", "float", "datetime", "time", "sine_trend", "linear_trend", "one_hump_trend", "unicode", "email"]

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
data = FakeData.new(options[:baddata], num_rows)

# Shuffle the column types
for i in 0..(num_cols-1)
  col_types << data_types[i%data_types.length]
end
col_types = col_types.shuffle
col_types << "index"

# Use the data type as the column headers
csv << col_types.join(",") + "\n"

puts "Creating CSV with #{num_rows} rows of columns of type:\n#{col_types}"

for i in 1..num_rows
  print "\rWriting row #{i}."

  for type in col_types
    # Make a shuffled string of the desired data
    case type
      when "alphanumeric"
        row << data.alphanumeric
      when "numeric"
        row << data.numeric
      when "float"
        row << data.float
      when "date"
        row << data.date
      when "time"
        row << data.time
      when "datetime"
        row << data.datetime
      when "special"
        row << data.special
      when "sine_trend"
        row << data.sine_trend
      when "linear_trend"
        row << data.linear_trend
      when "one_hump_trend"
        row << data.one_hump_trend
      when "index"
        row << i.to_s
      when "unicode"
        row << data.unicode_string
      when "email"
        row << data.email
    end
  end

  # Add the string to the file as a row of the csv
  csv << row.join(",") + "\n"
  row = []
end

csv.close

puts "\rThe file #{output_file} has been written."
