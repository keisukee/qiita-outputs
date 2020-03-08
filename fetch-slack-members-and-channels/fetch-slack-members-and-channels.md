title: Slackのチャンネル一覧と、そこに所属しているユーザー一覧をCSV出力する


## はじめに
インターン先であるとき、Slackのチャンネル一覧と所属しているメンバー一覧のデータがほしい、となり、ちゃちゃっとプログラムでぱぱっとデータを取得するために色々試行錯誤したので、その結果をまとめます。
Slack APIは、legacy tokenとoauth2.0によるtokenの2種類の方式があるのですが、legacy tokenのほうが2020年5月に廃止になってしまうということで、本記事は新しいoauth2.0による方式で実行しました。

tokenを発行するために、若干つまずいたので、そこらへんも丁寧に解説します！


- [はじめに](#%e3%81%af%e3%81%98%e3%82%81%e3%81%ab)
- [本記事でやらないこと](#%e6%9c%ac%e8%a8%98%e4%ba%8b%e3%81%a7%e3%82%84%e3%82%89%e3%81%aa%e3%81%84%e3%81%93%e3%81%a8)
- [Slack連携のやり方](#slack%e9%80%a3%e6%90%ba%e3%81%ae%e3%82%84%e3%82%8a%e6%96%b9)
- [スクリプト](#%e3%82%b9%e3%82%af%e3%83%aa%e3%83%97%e3%83%88)
- [今回使用するAPIの説明](#%e4%bb%8a%e5%9b%9e%e4%bd%bf%e7%94%a8%e3%81%99%e3%82%8bapi%e3%81%ae%e8%aa%ac%e6%98%8e)
- [最後に](#%e6%9c%80%e5%be%8c%e3%81%ab)


## 本記事でやらないこと
- bot作成
- webhookを使ってうんちゃらかんちゃら
- slackのアクションにsubscribeして何かを実行する
- サーバーを立てる

とりあえずローカル環境でslackのAPI叩いて、データをゲットしたよね、ってぐらいのノリ。

## Slack連携のやり方
まず、トークンを発行するために、slackと連携します。

https://api.slack.com/apps


<img width="1439" alt="スクリーンショット 2020-03-08 18.50.48.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/e7bc1c4c-15a0-63c6-2b0d-655cdbf4042a.png">




アプリの名前とワークスペースを選択して次に行きます。

<img width="1434" alt="スクリーンショット 2020-03-08 18.54.04.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/a9542e92-a80c-4ceb-0023-3a49402b2e4a.png">


次、↑の画像のように、「Oauth & Permissions」というところに行き、「Scope」の設定をします。
SlackのAPIでは、作成したアプリごとにscopeをわけて、権限を管理します。

今回は、
- チャンネルの取得
- ユーザーの取得

ができればいいので、設定する必要があるscopeは2つ、`users:read`と`channels:read`です。


<img width="1435" alt="スクリーンショット 2020-03-08 18.57.07.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/ac28a5e3-31c3-67f2-1ac7-c6c72d158a03.png">


↑のように設定したら、スクリプトを実行するのに必要な権限が設定できました。次にトークンを発行します！

Settingsの「Install App」にいき、アプリをインストールします。これを実行しないとトークンが発行できないです。


<img width="1426" alt="スクリーンショット 2020-03-08 18.58.06.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/73dbfbd2-a34c-11bd-9628-6fcbf6eecb3f.png">


「Install App to Workspace」をクリックします。

<img width="1439" alt="スクリーンショット 2020-03-08 18.58.37.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/686b91f1-3081-ee13-625a-dc99e206d4db.png">


こんな感じで`Oauth Access Token`が発行できました。これを使うと、SlackのAPIが実行できます！

<img width="1432" alt="スクリーンショット 2020-03-08 18.58.25.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/b453eb8d-f3bc-e771-2ace-7ccadb1fb0c0.png">

## スクリプト
と、その前に発行されたトークンが正しく機能しているか実験してみましょう。

```
curl https://slack.com/api/conversations.list?token=発行したトークン
```

で、それっぽいレスポンスが返ってきたら成功です！

さて、チャンネル一覧と、各チャンネルに所属しているメンバー一覧を出力するスクリプトは以下のようになります。

なお、Rubyで書いてあるので、各自で言語は読み替えてください！

```
touch slack.rb
```

slack.rb
```ruby
require 'net/http'
require 'uri'
require "json"
require 'pp'

TOKEN = "発行したトークン"
SLACK_API_BASE = 'https://slack.com/api'

# チャンネル一覧を取得するAPI
fetch_all_channels_url = "https://slack.com/api/conversations.list?token=#{TOKEN}"
res = Net::HTTP.get(URI.parse(fetch_all_channels_url))
channel_hash = JSON.parse(res)
channels = channel_hash["channels"]
channels = channels.select { |channel| !channel['is_archived'] && !channel['num_members'].zero? } # 削除されたチャンネルや所属人数が0のチャンネルを除外

# メンバー一覧を取得するAPI
fetch_all_members_url = "#{SLACK_API_BASE}/users.list?token=#{TOKEN}"
res = Net::HTTP.get(URI.parse(fetch_all_members_url))
members_hash = JSON.parse(res)
members = members_hash["members"]
members = members.reject { |m| m["deleted"] } # 削除されたユーザーを除外

channels.each do |channel|
  # あるチャンネルに入っているユーザー一覧を取得
  fetch_members_in_channel_url = "#{SLACK_API_BASE}/conversations.members?token=#{TOKEN}&channel=#{channel['id']}"
  res = Net::HTTP.get(URI.parse(fetch_members_in_channel_url))
  next unless res["ok"]

  user_hash = JSON.parse(res)
  user_ids = user_hash["members"]
  user_list = []

  user_ids.each do |id|
    member = members.detect { |m| m["id"] == id }
    user_list << member["real_name"] if member
  end
  # csvで出力
  puts "#{channel['id']},#{channel['name']},#{user_list.join(",")}"
end
```

あとは、実行するだけです

```
bundle install

ruby slack.rb > data.csv
```

実行結果はこんな感じ
```
C40DMBLHX,general,山田花子,山田太郎,hoge,fuga（以下チャンネルに所属するメンバーすべて）
...
```

githubでコードは公開しているので、そちらもご参照ください！

https://github.com/keisukee/fetch-slack-channels-and-members/

## 今回使用するAPIの説明
蛇足ですが、せっかくけっこう調べたので、アウトプットをしておきます。SlackのAPIの中にも、`deprecated`になっているエンドポイントがちょいちょいあります。

僕が今回公開しているコードも、元のコードは別のQiitaの記事から取ってきたのですが、使用しているエンドポイントが非推奨になっていたため、そこは変更しました。

今回叩いているエンドポイントは以下のとおりです。

```
ユーザー一覧を取得するAPI
https://slack.com/api/users.list

チャンネル一覧を取得するAPI
https://slack.com/api/conversations.list

チャンネルに所属するユーザーを取得するAPI
https://api.slack.com/methods/conversations.members
```

https://api.slack.com/methods/users.list

https://api.slack.com/methods/conversations.list

https://api.slack.com/methods/conversations.members

詳しくはドキュメントに書いてあるのですが、APIのリミットレートもありまして、`Tier1`から`Tier4`まで。今回使用しているエンドポイントはどれも`Tier4`のもので、`100 requests per minute`の制限がかかっております。

https://api.slack.com/docs/rate-limits


## 最後に
退屈なことはプログラムにやらせましょう！

このプログラムを実行すれば、数分ですべてのデータが出ますが、同じ作業を手作業でやるとなると、途方にくれますよね。viva プログラミングです！