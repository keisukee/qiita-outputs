require 'open-uri'
# require 'mechanize'
require 'nokogiri'
root_url = "https://ja.wikipedia.org"
target_url = 'https://ja.wikipedia.org/wiki/%E6%84%9B%E7%94%B2%E5%85%89'

charset = nil

html = open(target_url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
count = 0

doc.css('table.infobox').each do |node|
  infos = node.css('tr')
  begin
    infos.each do |info|
      links = info.css('a')
      birthday_infos = []
      links.each do |link|
        if link.text.match(/.*年/) || link.text.match(/.*月.*日/)
          birthday_infos << link.text
        end
      end
      puts birthday_infos.join if birthday_infos.length > 0
    end
  rescue => e

  end
end

