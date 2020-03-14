title: 【26選】駆け出しRailsエンジニアが抑えておきたいgem大全

# はじめに

つい最近、Railsエンジニアとしてインターンを始めてからの業務経験が1年を超えました。業務未経験からweb系の自社開発企業に入ったときに感じたのは、**「うわっ...、私の知らないgem多すぎ?」**でした。

そこから必死に業務に食らいつき、知らなかった数々のgemについて知見を深めてきました。今では、知らないgemでもドキュメントを読めばインストール・カスタマイズがだいたいできるようになりました。

ということで今回は、業務未経験からRailsエンジニアになった方が、現場に入ったときに**最低限これさえ抑えていけばOK**というgemを解説や参考記事つきで紹介したいと思います！

昔の自分がこの記事を読んだら、**「ありがてえ、ありがてえよ...」**と思うことうけあいです！


# gem一覧

## フロントエンド系

### [sass-rails](https://github.com/rails/sass-rails)
### [slim-rails](https://github.com/slim-template/slim-rails)
### [haml](https://github.com/haml/haml)

#### 解説
基本的に、cssはscss,もしくはsassという拡張言語で書きます。

HTMLに関しては、`erb`で書くこともあるのですが、`slim`,または`haml`という拡張言語で書くことのほうが多いかなと思われます。僕はプログラミングスクールで`erb`を勉強したのですが、インターン先が`haml`で、「うっわ、こんなに簡単にHTMLが書けるんや！」とびっくりしました。

参考までに、`erb`,`haml`,`slim`で同じコード、`css`,`scss`,`sass`で同じコードを書いてみます。

```sample.html.erb
<ul class="user-list" id="list">
  <% @users.each do |user| %>
    <li>
      <p>
        <%= user.name %>さん。
      </p>
    </li>
  <% end %>
</ul>
```
```sample.html.haml
%ul.user-list#list
  - @users.each do |user|
    %li
      %p = user.name
```
```sample.html.slim
ul.user-list#list
  - @users.each do |user|
    li
      p = user.name

```

```sample.css
.user-list {
  padding: 10px;
}

.user-list li {
  padding-right: 15px;
}

.user-list li p {
  font-size: 16px;
  font-weight: bold;
}

```

```sample.scss
.user-list {
  padding: 10px;
  li {
    padding-right: 15px;
    p {
      font-size: 16px;
      font-weight: bold;
    }
  }
}
```

```sample.sass
.user-list
  padding: 10px
  li
    padding-right: 15px
    p
      font-size: 16px
      font-weight: bold
```



#### 参考記事

[RailsのHTMLテンプレートエンジン、Slimの基本的な記法
](https://qiita.com/mom0tomo/items/999f806d083569529f81)

[これからはcssはSassで書こう。
](https://qiita.com/m0nch1/items/b01c966dd2273e3f6abe)

## ユーザー登録系

### [devise](https://github.com/plataformatec/devise)
### [sorcery](https://github.com/Sorcery/sorcery)

#### 解説
プログラミングスクールのカリキュラムやRailsの参考書などでは、ユーザー登録機能を1から自力で実装することが多いと思いますが、実務ではそのような**車輪の再発明**はしません。ユーザー登録機能では、`devise`がデファクトスタンダードで、二番手で`sorcery`が出てくる、といった感じです。僕は`devise`しか使用した経験がありません。

ちなみに、`devise`はそのセットアップの簡易性ゆえにめちゃくちゃ便利なんですが、カスマイズの幅が無限大で、時々カオスになるため、**deviseは沼**という言説が流布しています。

#### 参考記事
[[*Rails*] deviseの使い方（rails5版）
](https://qiita.com/cigalecigales/items/f4274088f20832252374)

## 権限管理系
### [cancancan](https://github.com/CanCanCommunity/cancancan)
### [pundit](https://github.com/varvet/pundit)
#### 解説

企業では、エンジニア以外の社員もプロダクトを触ったりするため（自社メディアで記事を書いくなど）、様々な権限をもつユーザーを生成することがよくあります。

そういうときに出てくるのが上述したgemです。例えば、権限が`admin`のユーザーはなんでもできる、権限が`writer`のユーザーは記事の執筆ができる、権限が`normal`のユーザーは外部向け、なんて分類が簡単にできるようになります。

## 管理者画面系
### [rails_admin](https://github.com/sferik/rails_admin)
### [active_admin](https://activeadmin.info/)
### [administrate](https://github.com/thoughtbot/administrate)

#### 解説
実務では、プロダクトを運営する際に、**管理者画面**というものを扱うことになります。そこからデータを投入したり、データを分析したりします。非エンジニアもエンジニアも触る画面のため、使用方法などがわかりやすくある必要があるのがポイントです。

僕は`rails_admin`と`active_admin`を使用したことがありますが、どちらも一長一短（でした。個人的には`active_admin`のほうが好きです。

結局の所は、設定の簡単さとカスタマイズの簡単さのトレードオフなので、プロダクトの仕様や開発の進捗度合いなどを考えてgemを選択する必要があるかなという感じです！


#### 参考記事

[rails管理画面系gem比較してみた
](https://qiita.com/baban/items/f751fb05c4d2367878aa)

## 開発効率アップ系
### [annotate](https://github.com/ctran/annotate_models)
#### 解説
モデルやルーティングの情報を書き出してくれるgemです。

これを使うと、
- `rails routes`をしてルーティングを確認
- `db/schema.rb`を見て、モデルの情報を確認

といった作業から開放されます！

#### 参考記事

### [bullet](https://github.com/flyerhzm/bullet)
#### 解説
僕は駆け出しの頃、`N+1問題`をよく発生させてました。僕は駆け出しの頃、そもそも`N+1問題`の存在すら知らなかったです（社員の方にコードレビューで指摘してもらい初めて`N+1問題`を知りました）。

N+1問題とは、要はSQLのクエリーが必要以上に発行されてしまって動作が遅くなるということなんですが、この`bullet`というgemは、その`N+1問題`を検知してくれる頼れるヤツなんです。

#### 参考記事
[【Rails】annotateの使い方
](https://qiita.com/kou_pg_0131/items/ae6b5f41c18b2872d527)

### [rollbar](https://github.com/rollbar/rollbar-gem)
#### 解説
ローカルで動作確認はした、テストコードは書いた、そんな場合でも、本番環境でエラーが発生してしまうことはあります。

そういうときに便利なのがエラー検知ツールで、そのうちの一つがこの`rollbar`でございます。Slackと連携して、エラーが起きたらSlackに自動通知、といったこともできます。

#### 参考記事
[運用に耐えるRailsによるWebアプリケーションの作り方
](https://qiita.com/seri_k/items/605e6f75da838ae00007)

## デバッグ系
### [web-console](https://github.com/rails/web-console)
### [pry](https://github.com/pry/pry)
#### 解説
ローカルで開発をしているとき、エラーにぶち当たることは日常茶飯事です。エラーをデバッグするときに便利なのが、上で紹介しているgemたちです。


#### 参考記事
[web-console を使えば Rails App のデバックが楽になる
](https://qiita.com/pekepek/items/74c8b1f4c886fc9b15cd)

## スクレイピング
### [nokogiri](https://github.com/sparklemotion/nokogiri)
#### 解説
Railsでスクレイピングといったら`Nokogiri`、そんな感じのgemです。僕はこのgemを使ってエロサイトを作ったりしてました。

#### 参考記事
[Rails×スクレイピングでインスタ風エ○サイトをリリースしました！
](https://qiita.com/sukebeeeeei/items/48b3348d011d4c2b256d)

## 画像系
### [cloudinary](https://github.com/carrierwaveuploader/carrierwave)
### [carrierwave](https://github.com/cloudinary/cloudinary_gem)

#### 解説
画像をゴニョゴニョするときには、だいたいこいつらを使います。画像サイズを変更したり、本番環境でAWSのS3にアップロードしたり、そういうことができます。

## ページネーション
### [kaminari](https://github.com/kaminari/kaminari)
#### 解説
ページネーションがまさにkaminariの早さで実装できます。

## 多言語対応
### [i18n](https://github.com/ruby-i18n/i18n)

#### 解説
例えばAdminUserモデルを作ったときに、`AdminUser`に対して、どういう言葉を当てるでしょうか。`ユーザー`でしょうか、`管理者`でしょうか、`アドミン`でしょうか、`アドミンユーザー`でしょうか。

仮にそのサービスで世界規模でバズり、英語圏のみならず、フランス語圏やスペイン語圏などにも広まった場合、どうするでしょうか。

`i18n`は、そういう`サービス上の用語`に対して一覧で訳語を当てることができます。このgemを使うことで、DRYかつスケールするようにできるわけですね。

#### 参考記事
[i18nについて
](https://morizyun.github.io/ruby/rails-function-i18n-internationalization.html)

## 環境変数・秘密鍵管理
### [dotenv](https://github.com/bkeepers/dotenv)
#### 解説
環境変数やら秘密鍵やらを管理するのに使います。
#### 参考記事
[Pathを通すとは、環境変数とは
](https://qiita.com/fuwamaki/items/3d8af42cf7abee760a81)

## テスト
### [rspec](https://github.com/rspec/rspec)
### [factory_bot](https://github.com/thoughtbot/factory_bot)

#### 解説
今でこそ告白しますが、インターンとして働くようになるまで、**テストコードを書いたことがありませんでした。**

しかし、まあ当たり前なんですが、実務でのテストコードの重要性を知り、機能の追加とテストは1セット、ということを実感しました。

Railsで動いているサービスだと、だいたい、上記のgemを使ってテストコードを書きます。
`rspec`がテストコードを書くためのgem、`factory_bot`がテストをする際のデータ生成のgem、といった感じです。

他にも、テストを書くためにほかのgemを使うんですが、それは`rspec`でテストを書けば自ずと使うようになるので、わざわざ本記事で紹介はしません。

#### 参考記事
[使えるRSpec入門・その1「RSpecの基本的な構文や便利な機能を理解する」
](https://qiita.com/jnchito/items/42193d066bd61c740612)

## リンター
### [rubocop](https://github.com/rubocop-hq/rubocop)
#### 解説
コードを解析して、非推奨の書き方などを指摘してくれる頼れるヤツです。CircleCIに組み込んで、非推奨の書き方があったら自動的にテストが失敗させる、といったこともできます。

ちなみに僕はvscodeを使ってるのですが、rubocopのプラグインを入れると、リアルタイムでコードを指摘してくれるので、非常に勉強になります。

#### 参考記事
[rubocopでrubyコードのベストプラクティスを学ぶ(Rails + Visual Studio Code)](https://blog.matzryo.com/entry/rubocop_on_rails_with_vscode)

## メール送信系
## [letter_opener](https://github.com/ryanb/letter_opener)
## [letter_opener_web](https://github.com/fgrehm/letter_opener_web)
#### 解説
メール送信機能を実装するとき、ローカルで使うことになるgemです。

ローカル環境で実在するメールアドレスにメール送信されたらウザいですよね。そういうときにこれらのgemを入れておくと、送信メールをキャッチしてくれるので便利です。


`letter_opener`と`letter_opener_web`の違いはというと、`letter_opener`は、メール送信が実行されるたびに別タブを開いてメールの中身を閲覧できます。`letter_opener_web`は、送信したメールを`localhost:3000/letter_opener`でまとめて閲覧できます。

個人的には`letter_opener_web`のほうが使いやすいですね！
#### 参考記事
[開発中にrailsから送信したメールを確認する
](https://qiita.com/k-shogo/items/d85905535a64e82a3b2b)