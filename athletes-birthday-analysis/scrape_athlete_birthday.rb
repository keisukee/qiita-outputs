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

  is_year_gotten = false
  is_month_gotten = false
  is_day_gotten = false
  doc.css('a').each do |link|
    p link
    begin
      birthday_infos = []
      if link.text.match(/[0-9]{4}年/)[0] && !is_year_gotten
        puts link.text
        birthday_infos << link.text
        is_year_gotten = true
      elsif link.text.match(/[0-9]{1,2}月[0-9]{1,2}日/)[0] && !is_month_gotten && !is_day_gotten
        puts link.text
        birthday_infos << link.text
        is_month_gotten = true
        is_day_gotten = true
      elsif link.text.match(/[0-9]{1,2}月/)[0]
        puts link.text
        birthday_infos << link.text
        is_month_gotten = true
      elsif link.text.match(/[0-9]{1,2}日/)[0]
        puts link.text
        birthday_infos << link.text
        is_day_gotten = true
      end
      if is_year_gotten && is_month_gotten && is_day_gotten
        p birthday_infos
        puts birthday_infos.join
        break
      end
    rescue => e
    end
  end
end

player_data = read_file("data_baseball_player.txt")

# player_data.each do |player|
  get_birthday("https://ja.wikipedia.org/wiki/%E7%9B%B8%E5%B7%9D%E9%80%B2")
# end

# url = 'https://ja.wikipedia.org/wiki/%E6%84%9B%E7%94%B2%E5%85%89'


