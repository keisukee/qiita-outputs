title: パス（PATH）を通すと聞いてチンプンカンプンな人が読む記事

# はじめに
初めてインターンとして会社に通った日のことを今でも昨日のことのように思い出せます。

インターンの初日、Macbookを貸与された僕は、環境構築に取り掛かりました。社内の方が残してくれたドキュメントを参考に、当時の自分にとってはわけのわからない呪文をひたすらコマンドラインに打ち込んでいました。

わけのわからないコマンドでも、見たとおりにやればそれなりにうまくいきましたが、あるとき、その限界が来ました。それが、**「パス（PATH）を通す」**、という用語に邂逅した瞬間でした。

恥ずかしながら当時の自分は、パスはおろか、シェルについてもろくな知識を持ち合わせておりませんでした。zshとかbashとか言われても、「ハァ？」みたいな感じです。

そこから1年と少しが経過した今では、独自のシェルスクリプトを書いて効率化を図ったり、環境構築したり、PATHを通したり、といったことが楽勝でできるようになりました。

そして最近になってようやく、**「どういう説明をすれば、パス（PATH）を通す、という用語の意味が駆け出しエンジニアの腑に落ちるか」**というのがわかってきたので、それをシェアします。

# 記事の対象者
- 業務未経験から就職し、環境構築の鬼畜難易度に泣きそうな人
- パス（PATH）を通すと聞いてチンプンカンプンな人
- ぶっちゃけ環境構築は運任せ、みたいな人

# パス（PATH）とはなにか
```
➜  ~ echo $PATH
/Users/keisuke/node_modules:/Users/keisuke/.nodenv/bin:/Users/keisuke/.nodenv/shims:/Users/keisuke/go/bin:/usr/local/opt/mysql@5.7/bin:/Users/keisuke/.goenv/shims:/Users/keisuke/.goenv/bin:/Users/keisuke/.pyenv/shims:/Users/keisuke/.pyenv/bin:/Users/keisuke/.rbenv/shims:/Users/keisuke/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/Library/TeX/texbin:/usr/local/go/bin:/opt/X11/bin:/usr/local/texlive/2018/bin/x86_64-darwin/:/Users/keisuke/dotfiles:/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk
➜  ~
➜  ~ echo $HOME
/Users/hoge
```

# パス（PATH）を通すとはなにか
```
export PATH="$HOME/node_modules:$PATH"
```
# 実際にパス（PATH）を通してみよう！

# 所感

# 参考記事
