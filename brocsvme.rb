# Create a csv with random data of preset types
# > make string of desired data type
# > shuffle the string to randomize it
# > chop up the string so it is the desired length of data

require "optparse"

row = []
csv_array = []
col_types = []
special = [".", "<", ">", "/", "\\", "?", ";", "&", "%", "$", "@", "`", "(", ")", "*"]
data_types = ["special", "string", "numeric", "float", "datetime", "time"]

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Use switches to customize the output csv."

  opts.on("-r", "--rows [NUMROWS]",
  "Number of rows in CSV") do |rows|
    options[:rows] = rows.to_i
  end

  opts.on("-c", "--columns [NUMCOLS]",
  "Number of columns in CSV") do |cols|
    options[:columns] = cols.to_i
  end

  opts.on("-n", "--name [FILENAME]", "File name") do |fname|
    options[:filename] = fname
  end

end

optparse.parse!

output_file = options[:filename]
output_file ||= "default_name.csv"
csv = File.open(output_file, "w" )

num_rows = options[:rows]
num_rows ||= 20
num_cols = options[:columns]
num_cols ||= data_types.length

# Shuffle the column types
for i in 0..(num_cols-1)
  col_types << data_types[i%7]
end
col_types = col_types.shuffle
# Use the data type as the column headers
csv << col_types.join(",") + "\n"

puts "Creating CSV with #{num_rows} rows of columns with type\n\n#{col_types}"

for i in 1..num_rows
  for type in col_types
    # Make a shuffled string of the desired data
    if type == "string"
      row << [*'a'..'z', *'0'..'9'].sample(rand(30)).join
    elsif type == "numeric"
      row << [*"0".."9"].sample(rand(26)).join
    elsif type == "float"
      row << [*"0".."9"].sample(rand(10)).join +
        "." + [*"0".."9"].sample(rand(6)).join
    elsif type == "date"
      row << [*"1".."12"].sample + "-" +
        [*"1".."31"].sample + "-" +
        [*"1980".."2050"].sample
    elsif type == "time"
      row << "\"" + [*"0".."23"].sample.rjust(2, '0') + ":" +
        [*"0".."59"].sample.rjust(2, '0') + ":" +
        [*"0".."59"].sample.rjust(2, '0') + "\""
    elsif type == "datetime"
      row << [*"1980".."2050"].sample + "-" +
        [*"1".."12"].sample.rjust(2, '0') + "-" +
        [*"1".."29"].sample.rjust(2, '0') + "T" +
        [*"0".."23"].sample.rjust(2, '0') + ":" +
        [*"0".."59"].sample.rjust(2, '0') + ":" +
        [*"0".."59"].sample.rjust(2, '0') + "-" +
        [*"0".."23"].sample.rjust(2, '0') + ":" +
        [*"0".."59"].sample.rjust(2, '0')
    elsif type == "special"
      row << "\"" + special.sample(rand(30)).join + "\""
    end
  end
  # Add the string to the file as a row of the csv
  csv << row.join(",") + "\n"
  row = []
end

csv.close

puts "\n#{output_file} has been written.\n"
