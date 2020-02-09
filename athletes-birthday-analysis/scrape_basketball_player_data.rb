require 'open-uri'
require 'nokogiri'
root_url = "https://ja.wikipedia.org"
target_url = 'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%90%E3%82%B9%E3%82%B1%E3%83%83%E3%83%88%E3%83%9C%E3%83%BC%E3%83%AB%E9%81%B8%E6%89%8B%E4%B8%80%E8%A6%A7'

charset = nil

html = open(target_url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
count = 0
doc.css('li').each do |node|
  link = node.css("a")
  begin
    url = link.attribute("href").value
    if url.include?("wiki")
      count += 1
      # puts node.text
      puts link.text
      puts root_url + url
    end
  rescue => exception
  end
end
puts count

