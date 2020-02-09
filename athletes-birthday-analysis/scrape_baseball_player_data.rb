require 'open-uri'
# require 'mechanize'
require 'nokogiri'
root_url = "https://ja.wikipedia.org"
target_url = 'https://ja.wikipedia.org/wiki/%E6%97%A5%E6%9C%AC%E3%81%AE%E3%83%97%E3%83%AD%E9%87%8E%E7%90%83%E9%81%B8%E6%89%8B%E4%B8%80%E8%A6%A7'

charset = nil

html = open(target_url) do |f|
  charset = f.charset
  f.read
end

def include_word_in_all_of_data?(array, word)
  array.each do |data|
    if word.include?(data)
      return true
    end
  end
  return false
end
team_data = ["読売ジャイアンツ",
  "阪神タイガース",
  "中日ドラゴンズ",
  "横浜DeNAベイスターズ",
  "広島東洋カープ",
  "東京ヤクルトスワローズ",
  "オリックス・バファローズ",
  "福岡ソフトバンクホークス",
  "北海道日本ハムファイターズ",
  "千葉ロッテマリーンズ",
  "埼玉西武ライオンズ",
  "東北楽天ゴールデンイーグルス",
  "愛媛マンダリンパイレーツ",
  "香川オリーブガイナーズ",
  "高知ファイティングドッグス",
  "徳島インディゴソックス",
  "新潟アルビレックス・ベースボール・クラブ",
  "富山GRNサンダーバーズ",
  "石川ミリオンスターズ",
  "信濃グランセローズ",
  "群馬ダイヤモンドペガサス",
  "福井ミラクルエレファンツ",
  "埼玉武蔵ヒートベアーズ",
  "福島レッドホープス",
  "滋賀ユナイテッドベースボールクラブ",
  "栃木ゴールデンブレーブス",
  "茨城アストロプラネッツ",
  "神奈川フューチャードリームス",
  "兵庫ブルーサンダーズ",
  "06BULLS",
  "和歌山ファイティングバーズ",
  "堺シュライクス",
  "琉球ブルーオーシャンズ",
  "埼玉西武ライオンズ・レディース",
  "埼玉アストライア",
  "愛知ディオーネ",
  "京都フローラ",
  "レイア",
  "翼軍",
  "名古屋金鯱軍",
  "西鉄軍",
  "大和軍",
  "西日本パイレーツ",
  "松竹ロビンス",
  "高橋ユニオンズ",
  "大映ユニオンズ",
  "大阪近鉄バファローズ",
  "三重スリーアローズ",
  "長崎セインツ",
  "福岡レッドワーブラーズ",
  "神戸9クルーズ",
  "大阪ゴールドビリケーンズ",
  "明石レッドソルジャーズ",
  "大阪ホークスドリーム",
  "神戸サンズ",
  "大和侍レッズ",
  "紀州レンジャーズ",
  "姫路GoToWORLD"]


doc = Nokogiri::HTML.parse(html, nil, charset)
count = 0
doc.css('li').each do |node|
  link = node.css("a")
  begin
    url = link.attribute("href").value
    if url.include?("wiki") && include_word_in_all_of_data?(team_data, node.text)
      count += 1
      # puts node.text
      puts link.text
      puts root_url + url
    end
  rescue => exception
  end
end
puts count

