# frozen_string_literal: true

class Memo
  # DBに接続し、@connectionにセット
  def initialize
    @connection = PG.connect(dbname: 'sinatra_memos')
  end

  # memosテーブルの全情報取得
  def read_all
    @connection.exec('SELECT * FROM memos')
  end

  # 受け取ったidの情報取得
  def read(id)
    @connection.exec('SELECT * FROM memos WHERE id = $1', [id])
  end

  # 受け取ったidを編集する
  def memo_edit(title, content, id)
    @connection.exec('UPDATE memos SET title = $1, content = $2 WHERE id= $3', [title, content, id])
  end

  # 新しいメモを作成
  def memo_create(title, content)
    @connection.exec('INSERT INTO memos(id, title, content) VALUES (DEFAULT, $1, $2)', [title, content])
  end

  # メモの削除
  def delete(id)
    @connection.exec('DELETE FROM memos WHERE id = $1', [id])
  end
end
