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
- ワイルドカード
  - `WHERE カラム like "%文?_字_列%" ESCAPE "?"`
  - ダブルクォーテーションでくくる
    - -: 任意の一文字
    - %: 任意の0文字以上
    - エスケープ処理
      - ESCAPE "?" // ?に限らず任意の文字で良い
- 正規表現
  - `WHERE カラム ~ '^[ab]?[^ab]+(a|b).{3,4}?$'`
  - `WHERE id ~ '^a.*(03|52)$`
- 否定：`where not name like "%プリン%";` // プリンを含まない
- `WHERE AAA BETWEEN "BBB" AND "CCC"`
- NULLは=ではなくisを使用する
  - x where column = NULL
  - o where column is NULL
- `select DISTINCT(name)`でnameカラムの重複を削除
- `FROM test_table as A`とするとtest_tableをAで呼べる
  - asは省略されることもある
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
    - selectで使えるのはGROUP BYに指定しているカラム名と集計関数だけ
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
  - 単一行副問い合わせ：1行1列
    - whereやset句と共に用いられる
    - SELECT文中で使用するとカラムになる
  - 複数行副問い合わせ：n行1列
    - 用途：IN、ANY、ALL演算子で使用する
      - ANYかALLでNULLが一つでも入ると比較結果はNULLになってしまう
        - COALESCEを使用して回避する（where is not nullでも可）
  - 表形式の副問い合わせ：n行n列
    - FROM句で利用する
    - INSERT句で利用する（複数行を挿入できる）
- 相関副問い合わせ：再帰的にサブクエリをする
  - 副問い合わせの内部から主問い合わせの票や列を利用する副問い合わせ
  - 例
    - `SELECT category, sum FROM budget WHERE EXISTS (SELECT * FROM budget WHERE budget.category = summary.item)`
    - 他のテーブルにも存在するcategoryを抽出する
    - DBの処理負荷は大きい
- AS
  - カラムを別名に定義する。エイリアスとも呼ぶ。
  - `SELECT goals AS "ウィルの得点数" FROM players WHERE name = "ウィル";`
  - asは省略可能
- 結合
  - InnerJoin:一致するキーがない場合は結合元のレコードごと表示されない
    - JOIN
      - ```sql
          SELECT p.country_id, p.status
          FROM players AS p -- エイリアスをつけると便利
          JOIN countries
          ON p.country_id = countries_id;
        ```
      - 順番：JOIN->SELECT
  - OuterJoin：一致がなくてもnullを追加して元の行を消さない結合
    - LEFT JOIN
      - キーがNULLの場合でも結合元のレコードが表示され、結合先はNULLになる
    - RIGHT JOIN
      - キーがNULLの場合は結合元のレコードにNULL行が追加され結合先の値が入る
    - OUTER JOIN（FULL JOIN）
      - どちらかのテーブルに値があれば結合する
      - MySQLとMariaDBでは無いのでUNIONで代用する
  - 複数回実行可能
- レコード追加
  - `INSERT INTO students (name, course) VALUES("Kate", "Java");`
    - VALUESはVALUEの単数ではなくVALUESの複数形
    - 全データを指定する場合はVALUESの前のカラム指定は省略可能
  - `create table users (id int unsigned auto_increment not null primary key, name varchar(32), ageint not null);`
- レコード更新
  - `UPDATE students SET name='Jordan', course='HTML' WHERE id = 6;`
  - 注意:WHERE句がないとすべてを更新してしまう
- レコード削除
  - `DELETE FROM students WHERE id = 6;`
  - 注意：WHERE句がないとすべてを削除してしまう
  - FROMのつけ忘れ注意
- offset 3で取得開始位置を指定できる。

## DB設定

- GRANT (権限付与):`GRANT 権限名 TO ユーザー名`
- REVOKE (権限剥奪):`REVOKE 権限名 FROM ユーザー名`
- カラムの初期値
  - DEFAULT
  - 自動採番
    - MySQL:AUTO_INCREMENT
    - PostgreSQL: GRANTED ALWAYS AS IDENTITY, SERIAL(型)
- カラムの制約
  - NOT NULL
  - CHECK( 条件式 )
  - UNIQUE
  - PRIMARY KEY
    - 複合主キーの場合PRIMARY KEY(カラム1, カラム2)
  - REFERENCES 参照先テーブル名(参照先カラム名)

## データベースオブジェクト

データの管理や操作のための仕組み

- index
  - `CREATE INDEX index_name ON table_name(column_name)`
  - 早くなるケース
    - WHERE句の完全一致と前方一致（部分一致と後方一致では効かない）
    - ORDER BYの並び替え
    - JOINによる結合条件
  - 主キー内部でインデックスが作られる
  - PLAN文で高速化を効果を測定できる
- view
  - select文に名前をつけたもの
- Sequence
  - 連番を作成する仕組み
    - `CREATE SEQUENCE(シーケンス名)`
    - `SELECT NEXTVAL(シーケンス名)`
    - `SELECT CURRVAL(シーケンス名)`
    - `DROP SEQUENCE(シーケンス名)`
  - 最近ではUUIDが使われる
    - Universal unique IDentifier
    - 世界標準のアルゴリズムで生成される128bitのランダム値

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

### 組み込み関数

- LENGTH：文字列の長さを返す
  - `WHERE LENGTH(商品名) >= 5` 5文字以上の商品名
  - `SELECT 商品名, LENGTH 文字数` select句にも使える
- TRIM:文字列の前後の空白を削除する
- REPLACE(検索対象, 置換対象文字, 置換後の文字)で置換する
- CONCAT(文字列1, 文字列2, ...)
- SUBSTRING：文字列から一部の文を切り出す
  - SUBSTRING, 文字位置、文字数
    - 文字位置に負の値も指定可能
  - `WHERE SUBSTRING("ID", 3, 2) BETWEEN '00` and '20'
    - IDの2文字目から2文字を抜き出し、その値が00~20のもの
- ROUND(数値, 桁数):四捨五入
  - ROUND(12.345,-1) //10
  - ROUND(12.345,0) //12
  - ROUND(12.345) //12 第二引数は省略可能で0になる
  - ROUND(12.345,1) //12.3
  - ROUND(12.345,2) //12.35
- TRUNC:指定桁で切り捨て
- POWER：冪乗
- CURRENT_TIMESTAMP, CURRENT_DATE, CURRENT_TIME
- `CAST(変換値 AS 変換後する型)`
- COALESCE：最初にnullでない値を返す
  - `SELECT COALESCE(nullがあるカラム, '置換後の文字列') AS foo`で見やすくする
- CASE

```sql
-- 単純CASE式
SELECT *
  CASE カラム
    WHEN  値1 THEN 結果1️
    WHEN  値2 THEN 結果2
    ELSE 結果3
  END 表示するカラム名
FROM table_a
-- 検索CASE式
SELECT *
  CASE  -- カラム名を書かない
    WHEN  条件1 THEN 結果1️
    WHEN  id = 'aaa' THEN 結果2
    ELSE 結果3
  END 表示するカラム名
FROM table_a
```

### キー

- 主キー(primary):唯一
- 複合主キー(composite):単体では主キーになり得ない列を組み合わせて主キーになる（氏名,住所,生年月日）
- 候補キー(candidate):主キーになり得るもの
- 代替キー(alternative):候補キーの中で主キーとして選ばれなかった方
- 代替キー(surrogate):

### 集合演算子

- データ型の一致が必要
- UNION：和集合：二つの検索結果を足し合わせる
  - 一つのテーブルでも可能
  - 組み合わせで3つ以上も可能
- EXCEPT(MINUS)：最初の検索から次の検索で重複したものを除く
- INTERSECT：2つの検索で重複するもの
