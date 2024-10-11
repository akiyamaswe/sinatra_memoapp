# sinatra-memoapp

sinatraを使ったメモアプリのプログラムです。
XSS対策、存在しないURLにアクセスした時に、404ページが表示される仕様になっています。

# How to use

1. 任意の作業ディレクトリで git clone してください。
```
$ git clone https://github.com/akiyamaswe/sinatra_memoapp.git
```

2. 作成された`sinatra_memoapp`ディレクトリに移動してください。
```
$ cd sinatra_memoapp
```

3. メモアプリが実装しているブランチにチェックアウトしてください。
```
$ git checkout -b sinatra_memoapp origin/sinatra_memoapp
```
4. rubyは`.ruby-version`ファイルに記載されたバージョンに合わせる。バージョンを合わせないと7.を実行できません。

5. Gemfileにリスト化したgemを一括インストールをおこなう。
```
$ bundle install
```
6. 4.のインストールが失敗したときにはアップデートを行い、再度実行する。
```
$ bundle update
$ bundle install
```
7. アプリケーションを立ち上げます。
```
$ ruby memoapp.rb
```
8. `http://localhost:4567/`にアクセスするとメモアプリのトップページが表示されます。