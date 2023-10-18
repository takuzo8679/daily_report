# SQL メモ

- 日付データのフォーマット：`"2017-01-08"`
  - ダブルクォーテーションでくくる
  - ハイフンで繋ぐ
  - 0 を足して２桁
- 正規表現：`like "%文字列%"`
  - ダブルクォーテーションでくくる
  - %がワイルドカード
- 否定：`where not name like "%プリン%";` // プリンを含まない
- NULL は=ではなく is を使用する
  - x where column = NULL
  - o where column is NULL
- `select DISTINCT(name)`で name カラムの重複を削除
- 計算
  - 単純計算：`select price, price * 1.10`で計算が可能
  - 合計:`select sum(price)`
  - 平均:`select avg(price)`
  - 最大:`select max(price)`
  - 最小:`select min(price)`
  - カラムデータ個数
    - `select count(price)`（null 含む）
    - `select count(*)`（null 除く）
- グループ化
  - `GROUP BY`
    - select で使えるのは GROUP BY に指定しているから無名と集計関数だけ
    - o: `SELECT SUM(price), purchased_at FROM purchases GROUP BY purchased_at`
    - x: `SELECT price, purchased_at FROM purchases GROUP BY purchased_at`
      - 集計されない
    - 複数指定:`GROUP BY
    - where 検索が行われたあとにグループ化される
  - `GROUP BY カラム名 HAVING 条件` グループ化してからさらに絞り込む
    - 検索対象
      - where は最初に実行されるのでテーブル全体
      - having は GROUP BY でグールプされたものを対象
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
  - カラムを別名に定義する
  - `SELECT goals AS "ウィルの得点数" FROM players WHERE name = "ウィル";`
- 結合
  - JOIN
    - ```sql
        SELECT *
        FROM players
        JOIN countries
        ON players.country_id = countries_id;
      ```
    - 順番：JOIN->SELECT
    - キーが NULL の場合は結合元のレコードごと表示されない
  - LEFT JOIN
    - キーが NULL の場合でも結合元のレコードが表示される
  - 複数回実行可能
- レコード追加
  - `INSERT INTO students (name, course) VALUES("Kate", "Java");`
  - VALUES は VALUE の単数ではなく VALUES の複数形
- レコード更新
  - `UPDATE students SET name='Jordan', course='HTML' WHERE id = 6;`
  - 注意:WHERE 句がないとすべてを更新してしまう
- レコード削除
  - `DELETE FROM students WHERE id = 6;`
  - 注意：WHERE 句がないとすべてを削除してしまう
  - FROM のつけ忘れ注意
