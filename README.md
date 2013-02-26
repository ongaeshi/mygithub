# MyGithub

自分のGithubレポジトリのソースコードをオフラインで高速に検索。

![mygithub](http://cdn-ak.f.st-hatena.com/images/fotolife/t/tuto0621/20130207/20130207000947_original.png)

- OAuthでGithubにログイン
- 全てのレポジトリをチェックアウト
- 検索用のインデックスを貼る
- [Milkode](http://milkode.ongaeshi.me/wiki/Main_Page)をバックエンドに使用

## Install

```
$ gem install mygithub
```

## Usage

```
$ mygithub
Tasks:
  mygithub help [TASK]  # Describe available tasks or one specific task
  mygithub init         # Init setting
  mygithub update       # Pull repositories
  mygithub web          # Startup web interface
```

## Setup

```
$ mygithub web
```

webアプリが起動したらGithubへの認証を通しましょう。

![login](http://cdn-ak.f.st-hatena.com/images/fotolife/t/tuto0621/20130207/20130207000948_original.png)

ログイン後、レポジトリをチェックアウトするのでしばらく時間がかかります・・

![mygithub](http://cdn-ak.f.st-hatena.com/images/fotolife/t/tuto0621/20130207/20130207000945_original.png)

この画面になればチェックアウト完了です、おめでとう！

- 自分が過去に書いた全てのソースからいつでも情報を引き出すことが可能です
- Milkodeベースの検索はとっても高速です *100000ファイル* 位なら1秒もかかりません。
- レポジトリをGithubに追加した時は *新しいレポジトリを取り込む* ボタンを押せば取り込めます
- ![github-button](https://raw.github.com/github/media/master/octocats/blacktocat-16.png) ボタンを押せば関連するGithubページにジャンプすることが出来ます

## Setup (Use command line)

Webアプリからの認証が上手く行かない時に。

```
$ mygithub init
Create -> /Users/ongaeshi/.mygithub/mygithub.yaml
Please edit YAML settings!
```

.yamlファイルにユーザー名と自身のGithubトークンを入力。

```yaml
---
username: ongaeshi
token: 12345678abcdefghijklmnopqrstuvwxyzj90909
```

updateコマンドを実行。

```
$ mygithub update
create     : /Users/ongaeshi/.mygithub/database/milkode.yaml
create     : /Users/ongaeshi/.mygithub/database/db/milkode.db created.
git        : git://github.com/ongaeshi/HideFileToggle.git
Cloning into '/Users/ongaeshi/.mygithub/database/packages/git/HideFileToggle'...
.
.
```

webアプリ起動。

```
$ mygithub web
```

## Pow
一度認証が終われば[Pow](http://pow.cx/)経由で使うことが出来ます。例えば http://mygithub.dev でアクセス出来るようにするには以下をどうぞ。

```
ln -s /opt/local/lib/ruby1.9/gems/1.9.1/gems/mygithub-0.1.0/lib/mygithub/web mygithub
```

## Memo
- 認証時は必ず http://127.0.0.1:9295 でアクセスするようにして下さい
- opensslが正しくインストールされていてもSSL証明書が設置されていないとダウンロードに失敗します → [対策](http://qiita.com/items/12457815d5cee3723b97)



