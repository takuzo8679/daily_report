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
  - 変数名は慣習として小文字のスネークケース
  - 多重代入可能：a,b = 1,2
  - false, nil以外はTrue:(0もtrue)
  - 定数
    - 大文字で始める。でも代入できてしまう。
  - 自己代入(nilガード)
    ```ruby
    # 通常
    if a == nil
      a = 10
    end
    # 一行
    a = 10 if !a
    # 自己代入
    a ||= 10 # a = a || 10 と同じ
    ```
- 整数
  - odd?, even?
  - to_s
- 文字列
  - rjust(2, '0') # 2桁で0埋め
  - 配列化:str.chars
  - 二文字ずつ配列化
    - str.scan(/\w\w/)
    - str.scan(/.{1,2}/)
- if文
  - if文は最後に評価された式を戻り値として返す
  - 後置if:`a *= 5 if hoge==fuga`
- メソッド
  - メソッド名は小文字のスネークケースが慣例
  - 最後に評価された式が戻り値になる
  - returnを書かないのが主流
    - 途中で脱出する場合に使われる
      - `return 'invalid value' if value.nil?`
  - 引数がない場合は()をつけないのが主流
    - def greet
    - end
- 配列
  - 作成：[*0..10]、（0..10).to_a
  - Array.new(5, 'default') # defaultを全要素が参照する
  - Array.new(5){'default}  # defaultに個別の値が入る
  - map/collect
  - select/find_all/reject
  - find/detect
  - sum(初期値を与えた文字列の連結も可能)
  - shuffle, revers
  - push, <<, shift
  - unique, join,
  - delete(一致する要素を削除)、delete_if
  - 要素取得:a[-1],a[-2,2],a.last,a.last(2),a.first(2)
  - [1,2,3,4,5][1,3]=100
  - 連結は破壊のconcatよりも非破壊の+を使う
  - 和集合|、差集合-、積集合&が扱えるが、集合を扱うSetクラスもある
  - 展開は`*`のsplat演算子を用いる:`*[2,3] # 2,3`
  - 文字列の配列作成`%w(applemelonorange)#=>["apple","melon","orange"]`
  - 配列がブロックパラメータに渡される場合、同じ数の引数を用意すると展開される
    - `[[1,2],[3,4]].each{|a,b| puts a=b}` # 3, 7
  - ()で入れ子になった配列から変数を取得できる
- 範囲を表すRangeオブジェクト
  - 宣言
    - (1..5)
    - (1...5) # 1から4.999まで
  - 配列に渡すとその範囲を取得できる
  - if文の範囲を簡略化
  - 配列化(配列[]の中に範囲オブジェクトと*を付加する)
    - `[*1..4]`または`(1..5).to_a` # [1,2,3,4]
    - `[*'a'.. 'd']`または`('a'.. 'e').to_a` # ["a","b","c","d"]
- ハッシュ
  - obj.each { |k, v| puts v}
  - obj.each { |k_v| puts k_v[0]+k_v[1]} # 配列に格納される
  - obj.keys, values
  - has_key?(:hoge), key?, include?, member?
  - obj.size
  - 比較
    - a==b 全key-valueが一致すれば順不同でもtrue
  - ハッシュの展開は**
    - obj = { a: 1 }
    - { b: 2 **obj} # { b: 2, a: 1}
    - { b: 2 }.merge(obj) でも同様
  - 引数としてハッシュを渡す場合は(が必要)
    - puts({a:1,b:2})
    - assert_equal ({a:1,b:2}), result
- シンボル
  - 任意の文字列と一対一に対応するオブジェクト
- 繰り返し
  - 変数を取り出す`{|val|}`の`{}`をブロックと呼び、`val`をブロックパラメータと呼ぶ
  - 番号指定パラメータ_1,_2は可読性が落ちるので実務では要検討
  - サンプル

```ruby
ary.each do |val| puts val end
ary.each { |val| puts val }
ary.each { |val| puts val }
ary.each.with_index(start_number){ |val, i| puts "#{i} #{val}" }
ary.each.with_index(){ puts "#{_2} #{_1}" } # 番号指定パラメータ
(1..4).each { |val| puts val } # rangeで記載
for val in ary do puts val end
ary.map{|s| s.upcase}
ary.map(&:upcase) # 省略記法
ary.map.with_index{|s,i| "#{i} #{s}"}
5.times {|i| puts i }
10.upto(14){|i| puts i}
14.downto(10){|i| puts i}
1.step(10,2){|i| puts n}
10.step(1, -2){|i| puts n}
```

    - 複数行はdo-end,1行は{}の使い分け
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
- 正規表現
  - 存在有無確認 
    - '123-4567' =~ /\d{3}-\d{4}/ # true
    - '123-4567' =~ /\d{3}-\d{1}/ # true
  - match
```ruby
text='私の誕生日は1977年7月17日です。'
m=/(\d+)年(\d+)月(\d+)日/.match(text)
# m=text.match(/(\d+)年(\d+)月(\d+)日/)でも同じ。matchはstringにも定義されているため
# m[0]#=>"1977年7月17日" m[1]#=>"1977" m[2]#=>"7" m[3]#=>"17"
```
- メソッド
  - 戻り値がbooleanの場合は?をつける慣例
    - `date.isSunday?`ではなく`date.sunday?`
	- !をつけると元の変数を上書きする(ex.revers!)
  - キーワード引数を指定できる`func(arg1: 1,arg2: 2)`
  - デフォルト引数がある`func(arg1=1,arg2=2)`
  - デフォルト引数に他の関数を指定するとその関数の戻り値となる
  - ?で終わるメソッドはtrue/falseで返る
    - isXXXの代わりに使うのが主流
  - !で終わるメソッド
    - !がつかないメソッドより危険という意味
    - 非破壊/破壊的メソッドの二つが用意されている場合は後者に!がつく
    - 破壊的メソッドでも非破壊的メソッドがない場合は!がつかない(ex.concat)
    - 破壊/非破壊に限らず安全/危険の2種類のメソッドが存在する場合にも!で区別される
  - safe navigation operator
    - 安全呼び出し
    - lonely operator(ぼっち演算子)
    - &.
    - a$.upcase # aがnilならnilが返る
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

## Minitest

```ruby
require 'minitest/autorun'
class SampleTest < Minitest::Test # 継承する
  def test_sample # Minitestはtest_で始まるメソッドを探す
    # 第一引数が期待値、第二引数がテスト値
    assert_equal 'RUBY', 'ruby'.upcase
    # assert a # trueを期待
    # refute a # falseを期待
  end
end
```

- その他のテストにRspecがある

## ライブラリ
- 標準ライブラリ読み込み：`require ライブラリ名`
- 自作ライブラリ読み込み：`require_relative path/ライブラリ名` .rbは不要　

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
