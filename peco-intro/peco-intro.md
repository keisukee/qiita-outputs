title: 退屈なコマンドはpecoに打たせよう
## **はじめに**

この記事のタイトルを**「無駄なコマンドを打たないただ一つのライブラリ peco」**にしようかなと最初は思っていました。が、似たようなライブラリは他にもあるので、このタイトルを採用しました。ただ一つじゃないのでね。こちらのタイトルでも、簡潔に要点が伝わるし面白いしで、いっかなと。

**pecoが最強。便利すぎてヤバイよって話です。**

**ターミナルの操作を限りなく高速化したいみなさんに本記事を捧げます。peco童貞の方にとっては、控えめに言っても人生が変わることになる1記事になるでしょう。自信作です。**

駆け出しエンジニアだった昔の自分に会ったら、何があってもこの記事を読ませると思います。

なお、pecoを使うよりいい方法とかライブラリがあるよ！、という方はぜひコメント欄にお書き込みください。ぜひともその秘伝の奥義をマスターしたいです。

## **pecoとは**

https://github.com/peco/peco

公式githubを見ても、pecoの凄さがよく伝わらないと思うので、僕が実際にpecoっている風景をお見せ致します。百聞は一見にしかずです。

↓こんな感じのことができるようになります。

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8dbfaa64-f58b-4f02-866f-acfb7df47231/peco-command-r-edited.gif](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8dbfaa64-f58b-4f02-866f-acfb7df47231/peco-command-r-edited.gif)

## **実行環境**

    シェル: zsh (zsh 5.7.1 (x86_64-apple-darwin19.0))
    
    OS: macOS Catalina (10.15.3)
    
    ターミナル: Iterm2

本記事では `.zshrc`   を編集しますが、 `bash`や `fish` の人は、各自で読み替えてください。ちなみに、僕はzshフレームワークの `oh-my-zsh` を使用しているので、もしかしたらそれが影響してたりしてなかったりするかも。

なお、ショートカットキーはmacの前提で話を進めています。

`.zshrc`に貼り付けるスクリプトについては、本記事の最後に公開します。まず先にpecoの凄さを知ってほしいので。

## **pecoの4奥義**

### **コマンド検索**

 `ctrl + r`でコマンドの履歴を検索できるわけですが、これをpecoで魔改造します。えげつなく便利になります。

- 単語で検索できる
- コマンドの途中から検索できる
- うろ覚えで検索できる
- 検索結果が変わる

と、優秀過ぎませんかね。これ。

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8dbfaa64-f58b-4f02-866f-acfb7df47231/peco-command-r-edited.gif](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8dbfaa64-f58b-4f02-866f-acfb7df47231/peco-command-r-edited.gif)

ちなみに、今回上げているgifの左下に、どんなキーを叩いたか、というのがわかるようになっています。何が起きているのか、参考になれば幸いです。

### **ディレクトリ移動**

ターミナル上で、タブを開くときに、毎回地道に `cd hoge/fuga/...`とやっている方に朗報です。

pecoを使うと、すべてのディレクトリ移動は一瞬で終わるようになります。この方法だと、ディレクトリの最後の名前さえ覚えておけばいいので、ものすごい楽ちんです。

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/29cdee70-f8a7-46ba-8667-42e7981f5ae8/peco-command-u.gif](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/29cdee70-f8a7-46ba-8667-42e7981f5ae8/peco-command-u.gif)

一度訪れたことのあるディレクトリは、以降ずっとpecoで移動できるようになります。相対パスではなくて、絶対パスで移動できるので、

**どのディレクトリからでも、すべてのディレクトリに移動できます！**

### **gitのbranch移動**

ブランチを毎回プルリクごとに切っていると、知らぬ間にブランチがものすっごい量になっていますよね。

軽めのタスクが大量、みたいなときは、ブランチが増えまくりではないでしょうか。ブランチの名前がわからない。ブランチの名前を確認するのも面倒だし、 `git checkout` のコマンドを打つのも面倒。そんな方にはpecoが効きます。

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1936eb08-1328-4323-8bb2-b3ca96513eba/peco-git-checkout-lb.gif](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1936eb08-1328-4323-8bb2-b3ca96513eba/peco-git-checkout-lb.gif)

ブランチの検索と移動が同時にできてしまうというすぐれもの。しかも、ブランチ名のうちの一部分さえ覚えていれば、後は勝手にpecoがフィルタリングしてくれるわけです。むっちゃ楽です。

ちなみに僕は、エイリアスで、 `g = git`, `co = checkout`と登録してあるので、ブランチ移動をするときはいつも、 `g co lb`と叩いています。これだけで、どこのブランチにも移動できちゃうんです。やばくないですか、peco

### **dockerのコンテナに入る**

dockerで立ち上げてコンテナの中に入りたい。そのためにまず、 `docker ps`でコンテナのプロセスIDを調べて、それをコピーして、 `docker exec -it id`  でコンテナに入る。

他の方がどうしているのかはわかりませんが、pecoを知る前の僕は毎回そんな感じでした。想像がつくと思いますが、むちゃむちゃ面倒くさかったです。

というわけで、ここでもpecoが役に立ってくれます。かゆいところに手が届く。まじpeco半端ないって。。。

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/381aaf00-cd34-4b3b-afb7-0d2282157415/peco-docker-container.gif](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/381aaf00-cd34-4b3b-afb7-0d2282157415/peco-docker-container.gif)

## 応用編：この記事に使う予定のgifをコマンドラインから作成する

さて、この記事では、pecoの4つの使い方を紹介しました。

最後に、普段僕がどのようにpecoを使っているのか、その一部始終をご覧いただければなと思います。下のgifで何をやっているのかといいますと、この記事に使うgifを `ffmpeg`というコマンドで、mp4から変換しているところです。

**何が起きてるのか、わけわかんねえってばよっ！**、という方は、↓のgifの後に使用したコマンドの解説を書いたので、そちらをご覧ください！

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8f2c6326-dc6a-458e-96fc-172592ebc3be/peco-make-gif.gif](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8f2c6326-dc6a-458e-96fc-172592ebc3be/peco-make-gif.gif)

### 逐一解説

背景: まず、下ごしらえとして、予めpecoの実践動画をQuickTimePlayerというソフトを使って撮影しました。保存の際に、わかりやすくするため、 `peco-docker-container`みたいな名前をつけました。なお、保存した動画たちは全部、 `~/Downloads`に存在しています。

1. ルートディレクトリから、 `~/Downloads` に移動します。このときにすかさずpecoを発動。 `command + u`で移動します
2. 保存した動画の名前がうろ覚えだったので、まずその動画一覧を表示させました。 `ll -t | head -10` というコマンドを使って、最新10件のファイル名を取得しています
3. gifに変換したいファイル名がわかったので、ターミナルのもう一つのパネルの方で、同じく `~/Downloads` にpecoを用いて移動
4. mp4をgifに変換するためのコマンドを `command + r` のコマンド検索で調べています。僕は以前にもgifをコマンドで作成したことがあったので、それを探しました。 `ffmpeg`というコマンドを使えばいいことはわかっていたのですが、引数の当て方とか、オプションの付け方はうろ覚えでした。なので、以前にこういうときのために、コマンドの雛形をつくっていたんですね。それが、 `# ffmpeg -i vibe.mov -r 10 vibe.gif`みたいな、シャープ（#）つきのやつです。シャープ以降はコマンドとして認識されないので、僕はよくメモとして使用しています。実際にコマンドとして使いたいときは、シャープを削除して、引数とオプションを修正して実行するって感じです。
5. 最後に、pecoの `command + r` で検索して、出てきた候補の一つを選択し、引数とオプションを修正し、 `ffmpeg -i peco-docker-container.mov -r 15 peco-docker-container.gif`を実行して、見事、gifに変換が完了しました！

っていう感じです。本当に一挙手一投足を細かく解説しましたが、至るところを工夫を凝らしていることがおわかりいただけたでしょうか。

## .zshrcに貼り付けるスクリプトを紹介
```
    brew install peco
```
でpecoがインストールできます。

インストールが完了したら、以下のコードを `.zshrc`に貼り付けるだけで、pecoが使えるようになれちゃいます！むっちゃ便利！
```
    # peco settings
    # 過去に実行したコマンドを選択。ctrl-rにバインド
    function peco-select-history() {
      BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
      CURSOR=$#BUFFER
      zle clear-screen
    }
    zle -N peco-select-history
    bindkey '^r' peco-select-history
    
    # search a destination from cdr list
    function peco-get-destination-from-cdr() {
      cdr -l | \
      sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
      peco --query "$LBUFFER"
    }
    
    
    ### 過去に移動したことのあるディレクトリを選択。ctrl-uにバインド
    function peco-cdr() {
      local destination="$(peco-get-destination-from-cdr)"
      if [ -n "$destination" ]; then
        BUFFER="cd $destination"
        zle accept-line
      else
        zle reset-prompt
      fi
    }
    zle -N peco-cdr
    bindkey '^u' peco-cdr
    
    
    # ブランチを簡単切り替え。git checkout lbで実行できる
    alias -g lb='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'
    
    
    # dockerコンテナに入る。deで実行できる
    alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'
```
## 最後に

退屈なコマンドはpecoに打たせましょう。生産性が爆発的に向上すること間違いなしです。