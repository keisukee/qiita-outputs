require 'open-uri'
# require 'mechanize'
require 'nokogiri'

def read_file(file_name)
  original_data = []
  count = 0
  File.open(file_name, "r") do |f|
    f.each_line do |line|
      if count % 2 == 0 && line
        original_data << []
      end
      if line.include?("スクレイピングできません")
        original_data[original_data.length - 1] << line.gsub(/\n/, "")
        count = 0
        next
      else
        original_data[original_data.length - 1] << line.gsub(/\n/, "")
        count += 1
      end
    end
  end
  original_data
end

def get_birthday(url)
  charset = nil
  html = open(url) do |f|
    charset = f.charset
    f.read
  end

  doc = Nokogiri::HTML.parse(html, nil, charset)
  count = 0

  ptags = doc.css('p')
  intro = ptags.inner_text
  puts intro.match(/[0-9]{4}年[0-9]{1,2}月[0-9]{1,2}日/) # YYYY年MM月DD日
end


data_file_name = ARGV[0] || "data_baseball_player.txt"
player_data = read_file(data_file_name)

player_data.each do |player|
  sleep rand(1.0..4.0)
  puts player[0]
  get_birthday(player[1])
end

# url = 'https://ja.wikipedia.org/wiki/%E6%84%9B%E7%94%B2%E5%85%89'


