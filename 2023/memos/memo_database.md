# database

## 用語

- 外部キー(foreign key)
  - 他のテーブルの関連行を指すための列

## 設計

- 設計手順
  - 要件定義

- 品目などの項目はidにして別のテーブルにする
  - JOINでくっつけて表示する
  - 値の置換が容易
  - 一つのテーブルで更新項目が多いと修正漏れが発生する

## トランザクション

- 副作用
  - ダーティリード
    - コミット前の状態が読めてしまうこと
    - ROLLBACKすると他方が不正の状態でコミットする恐れがある
  - 反復不能読み取り（non-repeatable-read)
    - SELECTで探索、WHEREで更新する間に誰かがUPDATEして内容が変わること
  - ファントムリード（phantom read）
    - 2回のselect分の間に誰かがinsertして行数が変わること
- トランザクション分離レベル
  - 安全性と速度はバランス
  - レベル
    - UNREAD COMMITTED  : dirty-read & non-repeatable-read & phantom-read
    - READ COMMITTED    : non-repeatable-read & phantom-read
    - REPEATABLE READ   : phantom-read
    - SERIALIZABLE      : nothing
  - 大抵はREAD COMMITTEDが選ばれる
  - SQLから設定できる
  - コミット毎に設定できる
- ロック
  - 排他ロック(exclusive lock)
    - 他からのロックを許可しない
    - 主にデータ更新時に使用
  - 共有ロック(shared lock)
    - 他からの共有ロックを許容する
    - データの読み取りに使用
  - 行ロックの取得:SELECT FOR UPDATE(NO WAIT)
    - SELECT分の末尾にFOR UPDATEを追加すると排他ロックがかかる
    - 後からロックをかけた方は前者がcommitかROLLBACKで解除するまで待たされる
      - NO WAITオプションを待たずに即時失敗となる
  - 表ロックの取得：LOCK TABLE
  - デッドロック
    - RDBMSが監視しており他方を失敗させる
    - 回避策：処理時間を短くする、ロック順を揃える