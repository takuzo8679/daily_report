# rubyメモ

- 標準I/O
  - 出力
    - puts :改行ありで戻り値nil
    - print:改行なしで戻り値nil
    - p :改行ありで戻り値は引数
  - 入力
    - gets.chomp
    - gets.chomp.to_iで整数変換
- 変数
  - 定数
    - 大文字で始める。でも代入できてしまう。
- 整数
  - odd?, even?
  - to_s
- 配列
  - 作成：[*0..10]、（[0..10].to_a
  - shuffle, revers
  - push, <<, shift
  - unique, join,
- ハッシュ
  - obj.each { |k, v| puts v}
  - obj.keys, values, has_key?(:hoge)
  - obj.size
- 繰り返し
  - サンプル

```ruby
ary.each do |val| puts val end
ary.each { |val| puts val }
for val in ary do puts val end
5.times {|i| puts i }
10.upto(14){|i| puts i}
14.downto(10){|i| puts i}
1.step(10,2){|i| puts n}
10.step(1, -2){|i| puts n}
```

    - 処理から抜ける：break if条件式
    - continue：next if条件式

- 変数展開
  - `puts "my name is#{name}"`
  - 注意`"`を使うこと`'`の場合はそのまま表示される
  - `"`は特殊文字を展開し、`'`の場合はそのまま表示するため
- 文字列とシンボル
  - 文字列：何らかのデータ(変数や定数を表す)記法 → "ruby"
  - シンボル：コードの一部となる。記法 →ruby
  - ハッシュでは同じように使用できるがシンボル記法が標準
- メソッド
  - 戻り値がbooleanの場合は?をつける慣例
    - `date.isSunday?`ではなく`date.sunday?`
	- !をつけると元の変数を上書きする(ex.revers!)
  - キーワード引数を指定できる
- コーディングルール
  - 公式はない
  - The Ruby Style guideが有名
    - https://github.com/fortissimo1997/ruby-style-guide/blob/japanese/README.ja.md
  - 静的解析ツールのRoboCopが上記のコーディングルールを満たすかチェックしてくれる
    - https://github.com/rubocop/rubocop#readme

## クラス

- サンプルコード
  ```ruby
    class User
  		attr_accessor :name # 外部からアクセス可能になる
  		attr_reader :name # read only
  		attr_writer :name # write only
      def initialize(name)
        @name =name
      end
      def hello
        puts "hello I am #{@name}!"
      end
    end
  user = User.new('takuzo')
  user.hello
  # アクセサ
  user.name = "emma"
  ```
- initializeメソッドで初期化
- アクセサ
  - インスタンス変数の定義例`attr_accessor :amount`
- 継承記載例`class Food < Menu`
- オーバーライド：そのまま`def hoge`
- 変数＠
  - @value :インスタンス変数：インスタンスに一つ持ち、外からアクセス可能
    - メソッド間で共有可能
  - @@value :クラス変数　　　：インスタンス共通＝クラスで一つ持ち、外からアクセス可能
  - 英大文字 : 定数 : インスタンス共通で一つ持ち、外からアクセス可能class::const
- クラスメソッド
  - 定義例。`def self.discountDay?`
  - インスタンスを生成せずに呼べる
  - 対：インスタンスメソッド
- アクセス権限
  - publicデフォルト
  - protected
  - private記載して改行してインテントした箇所が適用される
- ファイル構造
  - プログラム実行部分：index.rb、その他のクラス：menu.rb
  - ファイルの読み込み`require "./menu"`
- ライブラリ
  - date

## モジュール

- メソッドや定数をまとめたもの
- インスタンスの作成、継承がない
- 用途：関連するメソッドや定数をまとめてスコープに置きたいとき

```ruby
module modName
	# description
end
```

## 例外

```ruby
begin # try
	puts 1/0
rescue => ex # catch
	puts ex.message # ZeroDivisionError
	puts ex.class   # divided by 0
	puts ex
ensure # finally
 puts "finally"
end
```
