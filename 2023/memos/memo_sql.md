# SQLメモ

- テーブル
  - 作成
    - create table users (id int unsigned, name varchar(32), age int);
  - 詳細表示
    - desc users; -- description
  - 削除
    - drop table users;
- コマンドの実行順
  - FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY
- 正規表現：`like "%文字列%"`
  - ダブルクォーテーションでくくる
  - %がワイルドカード
- 否定：`where not name like "%プリン%";` // プリンを含まない
- NULLは=ではなくisを使用する
  - x where column = NULL
  - o where column is NULL
- `select DISTINCT(name)`でnameカラムの重複を削除
- `FROM test_table as A`とするとtest_tableをAで呼べる
- 計算
  - 単純計算：`select price, price * 1.10`で計算が可能
  - 合計:`select sum(price)`
  - 平均:`select avg(price)`
  - 最大:`select max(price)`
  - 最小:`select min(price)`
  - カラムデータ個数
    - `select count(price)`（null含む）
    - `select count(*)`（null除く）
- グループ化
  - `GROUP BY`
    - selectで使えるのはGROUP BYに指定しているから無名と集計関数だけ
    - o: `SELECT SUM(price), purchased_at FROM purchases GROUP BY purchased_at`
    - x: `SELECT price, purchased_at FROM purchases GROUP BY purchased_at`
      - 集計されない
    - 複数指定:`GROUP BY
    - where検索が行われたあとにグループ化される
  - `GROUP BYカラム名HAVING条件` グループ化してからさらに絞り込む
    - 検索対象
      - whereは最初に実行されるのでテーブル全体
      - havingはGROUP BYでグールプされたものを対象
    - 注意：条件にはグループ化されたカラム名(ex.sum(price))を使用
    - ```sql
      SELECT SUM(price), purchased_at,character_name
      FROM purchases
      GROUP BY purchased_at, character_name
      HAVING SUM(price) > 3000;
      ```
- サブクエリ
  - クエリの中に他のクエリを入れることができる
  - ()でくくる。例。：`WHERE goals > (select AVG(goals) from players)`
  - ;は不要
- AS
  - カラムを別名に定義する。エイリアスとも呼ぶ。
  - `SELECT goals AS "ウィルの得点数" FROM players WHERE name = "ウィル";`
  - asは省略可能
- 結合
  - JOIN
    - ```sql
        SELECT *
        FROM players
        JOIN countries
        ON players.country_id = countries_id;
      ```
    - 順番：JOIN->SELECT
    - キーがNULLの場合は結合元のレコードごと表示されない
  - LEFT JOIN
    - キーがNULLの場合でも結合元のレコードが表示され、結合先はNULLになる
  - RIGHT JOIN
    - キーがNULLの場合は結合元のレコードにNULL行が追加され結合先の値が入る
  - OUTER JOIN
    - どちらかのテーブルに値があれば結合する
  - 複数回実行可能
- レコード追加
  - `INSERT INTO students (name, course) VALUES("Kate", "Java");`
    - VALUESはVALUEの単数ではなくVALUESの複数形
  - `create table users (id int unsigned auto_increment not null primary key, name varchar(32), ageint not null);`
- レコード更新
  - `UPDATE students SET name='Jordan', course='HTML' WHERE id = 6;`
  - 注意:WHERE句がないとすべてを更新してしまう
- レコード削除
  - `DELETE FROM students WHERE id = 6;`
  - 注意：WHERE句がないとすべてを削除してしまう
  - FROMのつけ忘れ注意
- offset 3で取得開始位置を指定できる。

## データ型

### 数値型

- int:32bit
- int unsigned: 符号なし
- tinyint: -128~127, 01を扱う時に使用
- tinyint(1): bool。内部的には0/1で扱う
  - MySQLでは0,nullがfalse、空文字を含んでその他はtrue
- double: floatもあるがdoubleが使われる

### 文字列型

- char:固定の長さ。長さの指定はchar(5)で5文字。不足分はスペースで補完。最大255文字まで。
- varchar: 可変長の文字列。最大長さの指定はvarchar(5)。最大255文字まで。
- text: 長い文字列。最大65535文字。
- 実務上:255文字まではvarchar、それ以外はtextが多い

### 日付・時刻型

- date: YYYY-MM-DD
- datetime: YYYY-MM-DD hh:mm:ss.nnnnnn
- time: -838:59:59から838:59:59まで
- 日付データのフォーマット：`"2017-01-08"`
  - ダブルクォーテーションでくくる
  - ハイフンで繋ぐ
  - 0を足して２桁
