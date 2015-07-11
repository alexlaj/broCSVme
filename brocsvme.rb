prng = Random.new

num_rows = 20
num_cols = 5
alpha = ('a'..'z').to_a
numeric = ('0'..'9').to_a

row = []
csv_array = []

csv = File.open( "gotyou.csv", "w" )

col_types = Array.new(num_cols, 'string')

for i in 0..num_rows
  for type in col_types
    if type == 'string'
      row << (('a'..'z').to_a + ('0'..'9').to_a).shuffle[0,rand(30)].join
    elsif type == 'numeric'
      row << numeric.shuffle[0,rand(26)].join
    end
  end
  csv << row.join(",") + "\n"
  row = []
end

csv.close
