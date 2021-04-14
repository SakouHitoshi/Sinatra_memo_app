# Sinatra_memo_app

# このプロジェクトについて
Sinatraを利用した簡単なメモアプリのリポジトリです。
FJORD BOOT CAMPのプラクティス「Sinatraを使ってWebアプリケーションの基本を理解する」の課題の提出物です。

# アプリの概要
メモの作成、編集、削除が行える簡単なメモwebアプリになります。

# データベースの作成
1.自身のデータベースに接続
```shell
$ psql -U アカウント名  データベースの名前
```
2.メモのデータを保存するデータベースを作成
```sql
データベースの名前=# createdb sinatra_memos;
```
3.接続先のデータベースを`sinatra_memos`に変更
```shell
データベースの名前=# \q
$ psql -U アカウント名  sinatra_memos
```
4.テーブルを作成
```sqp
sinatra_memos=# create table memos (
  id serial not null,
  title text,
  content text,
  primary key (id)
);
```

# ローカルでの実行方法
1. `gem install sinatra`を実行してsinatraのgemをinstallする。
2. `git clone https://github.com/SakouHitoshi/Sinatra_memo_app`でローカル環境にクローンする。
3. `cd Sinatra_memo_app`でデイレクトリを移動し、`memo_app.rb`を実行。
4.  `Sinatra_memo_app`直下に`.env`ファイルを作成し、`DATABASE='sinatra_memos'`と記載
5. `http://localhost:4567`をブラウザに打ち込み表示する。
