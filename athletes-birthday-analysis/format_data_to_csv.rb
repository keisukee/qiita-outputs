require "csv"

file_name = ARGV[0]
file_data = []
count = 0
File.open(file_name, "r") do |f|
  f.each_line do |line|
    line.gsub!(/\n/, '')
    if count % 2 == 0
      file_data << []
    end
    file_data[file_data.length - 1] << line
    count += 1
  end
end


CSV.open("#{file_name}.csv",'w') do |csv|
  file_data.each do |data|
    p data
    csv << data
  end
end
