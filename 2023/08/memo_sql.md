# SQL メモ
- 日付データのフォーマット：`"2017-01-08"`
    - ダブルクォーテーションでくくる
    - ハイフンで繋ぐ
    - 0を足して２桁
- 正規表現：`like "%文字列%"`
    - ダブルクォーテーションでくくる
    - %がワイルドカード
- 否定：`where not name like "%プリン%";` // プリンを含まない
- NULLは=ではなくisを使用する
    - x where column = NULL
    - o where column is NULL
- `select DISTINCT(name)`でnameカラムの重複を削除
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
    - `GROUP BY カラム名 HAVING 条件` グループ化してからさらに絞り込む
        - 検索対象
            - whereは最初に実行されるのでテーブル全体
            - havingはGROUP BYでグールプされたものを対象
        - 注意：条件にはグループ化されたカラム名(ex.sum(price))を使用
        - 
            ```sql
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
        - キーがNULLの場合は結合元のレコードごと表示されない
    - LEFT JOIN
        - キーがNULLの場合でも結合元のレコードが表示される
    - 複数回実行可能

