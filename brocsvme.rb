require 'optparse'

row = []
csv_array = []
col_types = [] 
data_types = ['string', 'numeric', 'financial', 'date', 'datetime']

options = {}
optparse = OptionParser.new do |opts|
  opts.banner = 'Look options'
  
  opts.on('-r', '--rows [NUMROWS]', 
          'Number of rows in CSV') do |rows|
    options[:rows] = rows.to_i
  end

  opts.on('-c', '--columns [NUMCOLS]', 
          'Number of columns in CSV') do |cols|
    options[:columns] = cols.to_i 
  end

  opts.on('-n', '--name [FILENAME]', 'File name') do |fname|
    options[:filename] = fname
  end

end

optparse.parse!

output_file = options[:filename]
output_file ||= 'default_name.csv'
csv = File.open(output_file, "w" )

num_rows = options[:rows]
num_rows ||= 20
num_cols = options[:columns]
num_cols ||= 5

for i in 0..(num_cols-1)
  col_types << data_types[i%5]
end
col_types = col_types.shuffle

puts "Creating CSV with #{num_rows} rows of columns with type\n\n#{col_types}"

for i in 1..num_rows
  for type in col_types
    # Make a shuffled string of the desired data
    if type == 'string'
      row << (('a'..'z').to_a + 
              ('0'..'9').to_a).shuffle[0,rand(30)].join
    elsif type == 'numeric'
      row << ('0'..'9').to_a.shuffle[0,rand(26)].join
    elsif type == 'financial'
      row << '$' + ('0'..'9').to_a.shuffle[0,rand(10)].join +
             '.' + ('0'..'9').to_a.shuffle[0,rand(6)].join
    elsif type == 'date'
      row << ('1'..'12').to_a.shuffle[1] + '/' + 
             ('1'..'31').to_a.shuffle[1] + '/' +
             ('1980'..'2050').to_a.shuffle[1]
    elsif type == 'datetime'
      row << ('1'..'12').to_a.shuffle[1] + '/' +
             ('1'..'31').to_a.shuffle[1] + '/' +
             ('1980'..'2050').to_a.shuffle[1] + ' ' +
             ('0'..'24').to_a.shuffle[1] + ':' +
             ('0'..'60').to_a.shuffle[1] + ':' + 
             ('0'..'60').to_a.shuffle[1]
    end
  end
  csv << row.join(",") + "\n"
  row = []
end

csv.close

puts "\n#{output_file} has been written.\n"
