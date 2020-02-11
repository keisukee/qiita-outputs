require "csv"

file_path = ARGV[0]
file_data = []
count = 0

birth_month_dist = []
12.times do |i|
  birth_month_dist << 0
end
CSV.foreach(file_path) do |row|
    # 行に対する処理
  month = row[1].gsub(/\d{4}年/, "").gsub(/\d{1,2}日/, "").gsub("月", "")

  birth_month_dist[month.to_i - 1] += 1
end
puts birth_month_dist
