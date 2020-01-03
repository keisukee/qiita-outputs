![ezgif.com-gif-maker.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/9bdcb4d3-62aa-f84f-7876-ae71353004e6.gif)


こんな感じのエ○サイトをリリースしました。

**日曜日の朝からこんなどうしようもない記事ですみません。**

ちょっと、モラルとか公序良俗的にアレだったら削除します。

## はじめに

以前、こういうWebサイトをリリースしました。（リンクは外しています）
https\://nukistagram.herokuapp.com/

サイト名は、**Nukistagram（ヌキスタグラム）**です。はい、完全に某SNSを~~バクった~~もとい、着想を得ました。

**【注意】 ぶっちゃけ、ただのエ○サイトなので、開くときは気をつけてください**


## 制作経緯

Railsを初めて触ったときから1年も経過しました。長期インターンも経験しましたが、ふと思い返してみると、**自分の力だけでアプリを0から作り上げたことがなかったなと。**ポートフォリオないじゃん俺って。

プログラミングスクールでtwitterモドキとか、いろいろ作りましたが、ぶっちゃけ写経ばっかりだったので、個人開発童貞的なところがありました。

そんなとき、下記記事に出会いました。

[オシャレエロサイトをリリースして、10万PV/日を捌くためにやったこと](https://blog.inouetakuya.info/entry/20120410/1334058296)

この記事を見て、スケ少年は大変感銘を受けました。
そうだ京都に行こう、的なノリでナチュラルに、

**そうだ、エロサイトを作ろう**

と。

というわけで、n番煎じ的ではあるんですが、スクレイピング×Railsでエロサイトを作ろうと決意した次第です。

## 制作風景

制作期間は約3~4週間。大枠自体ははじめの2週間ぐらいでできたんですが、そこからの細かい詰め&Docker化&デプロイ作業がけっこうしんどかった。

以下、制作風景。
はじめて一週間ぐらいの頃。
![スクリーンショット 2019-06-07 1.28.30.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/e3fe65c7-dc73-64b9-d96f-f164464f7064.png)


スマホ版のviewをせっせと書く。
![スクリーンショット 2019-06-07 1.28.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/cc27a737-5392-80ae-e05b-01b7702d2e83.png)

ちょっとそれっぽくなってきた。

![スクリーンショット 2019-06-08 22.58.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/de496660-d939-9a3a-26a9-70fce5846b69.png)

さらにそれっぽくなってきた。大体ココらへんで２週間ぐらい経過。

<img width="300" alt="スクリーンショット 2019-06-09 19.30.46.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/a8fa5145-cc8c-1b19-de16-2cda86ed1310.png">


各ビデオの個別ページ。ワンコがかわいい♡
**見た目に騙されるとえげつないページに飛ばされます。**

<img width="297" alt="スクリーンショット 2019-06-13 16.00.25.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/09ccd167-d48b-3acc-3db3-b8917a62328f.png">


## 仕様

機能は至極シンプルなものに限定してます。頑張って便利な機能追加しても、**もしQiitaで渾身の記事を公開してスベったら取り返しのつかない精神的なダメージを食らいそうだったので。**

色々なサイトからスクレイピングで動画URL、サムネイル等を取得し、一覧にして表示してあります。

テーマとしては、
- 広告フリー
- おしゃれ
- シンプル
- ランキングつき
- 女優、ジャンルから検索できる


まあこれらを満たせばOKかなと。

## 技術スタック
**
- Ruby on Rails
- HTML(Haml), CSS(Sass)
    - CSSgram
- jQuery
    - Masonly
- DB
    - Postgresql
    - Redis
- CircleCI
- Docker


### インスタ風に
画像をインスタ風に加工するところは、CSSライブラリの[CSSgram](https://una.im/CSSgram/)を活用しました。wrapperを作って、class名をつけるだけで超簡単に画像がモダンになりました。

![スクリーンショット 2019-06-30 9.54.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/311529/eb4e2d63-471f-5fa2-55ab-c822b01f0a6d.png)
左が加工後、右が加工前


viewをインスタ風に再現するところでは、**jQueryのMasonly**に大変お世話になりました。**導入５分であら不思議、各ビデオがレンガ状に表示されて、ぐっとインスタっぽく。**

### 使用したgem
主に使用したgemは、スクレイピングのために**Nokogiri**、検索機能はベタにransackで実装。

### Docker化

Dockerでコンテナ開発をしています。以前インターンで働いてた企業では使ったことがなかったので初の試みでしたが、いやぁ**Dockerすごいですね。くっっっそ便利。**

### CircleCIでCI/CD

それに加えて、**CircleCIで自動テスト・自動デプロイを行っています。**masterブランチに各ブランチがmergeされたら処理が走って、そのままherokuにデプロイされます。いわゆるCI/CDってやつですかね？

**自動ってたいへん魅惑的な響きですよね。自分で初めて実装してみて思ったのですが、とてつもなく楽だなと。ガンガン開発が進むので楽しいです**

### ランキング機能

ランキング機能はNoSQLのRedisで実装しています。各ビデオのshowページに行くと、controller側で処理が走り、**PVのカラムがインクリメントされる仕組み。**ランキング機能の実装方法はいろいろあるのですが、NoSQLって使ったことがなかったのでいい機会かなと思い、redisを使うことに


## 実際に作ってみた感想
正直、2週間ぐらいでサクッとできるかと思っていたんですが、**Docker化、CircleCIの導入、redisでのランキング機能、管理画面の実装、viewの細かい調整、ローカルと本番環境の違い**、などで想像以上に手こずりました。

とはいえ、初めてのことばかりで刺激ある開発になったのかなと。やっぱり、Railsって便利だな、いや、便利すぎるなと実感する毎日でした。

**Nukistagram**を作っているうちに、色々と開発してみたいサービスのアイディアが浮かんできたので、今度はまともな（？）サービスを開発するつもりです。**さすがにポートフォリオがこれだけだと人間性を疑われそうなので。**

## 課題
欲を言えばここを直したい、というのは無限に出てくるんですが、時間は有限のため、泣く泣く諦めた箇所が多々あります。
例えば、

- P○rnhub以外のサイトからもビデオを取ってきたい
- スクレイピングしたものをそのままビデオのタイトルにしているが、これだと正直微妙。もうちょいそそるようなタイトルをつけたいし、英語タイトルのものは日本語に直したい
- あまりNukeない気がする
- もっとおしゃれにしたい
- recommend機能（この動画を見た人はこんな動画も見ています）を追加したい
- AWSへの移行

など。この記事がバズったらもうちょっと手を加えてもいいかなと考えてます。もしバズらなかったら...

## 参考文献・サイト・ライブラリ
- 参考文献・サイト
    - [DockerでRails環境構築 + CircleCIで自動テストとherokuへの自動デプロイを実行](https://qiita.com/kei_f_1996/items/934296e23b0d8d877ff1)
    - [オシャレエロサイトをリリースして、10万PV/日を捌くためにやったこと](https://blog.inouetakuya.info/entry/20120410/1334058296)
    - [HTML5/CSS3モダンコーディング フロントエンドエンジニアが教える3つの本格レイアウト スタンダード・グリッド・シングルページレイアウトの作り方 ](https://amzn.to/2YrozJq)
- ライブラリ
    - [CSSgram](https://una.im/CSSgram/)
  

