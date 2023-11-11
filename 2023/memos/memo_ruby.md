# rubyメモ

## 参考

- プロを目指す人のためのRuby入門

## 基本概要

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
    - 大文字で始める。でも代入できてしまう
      - 文字列、配列、ハッシュなどミュータブルな定数のメソッドには特に注意
      - `ARY = [1,2,3].freeze`でfreezeすると変更を防げるが、各要素は変更できてしまう
      - `ARY = [1,2,3].map(&:freeze).freeze`で各要素の変更も防げる
        - 工数が大きくなるのでプロダクトで対応の要検討
      - 上書きする人はいないだろうという思想
      - クラスの場合はfreezeで回避できるが、その後にメソッドの定義もできなくなるので実情使われない
    - トップレベルかクラス構文の直下での宣言が必要
      - メソッド内に限定した定数は構文エラー(dynamic constant assignment)
    - private_constant:を付加すると非公開にできる
    - クラス定数のアクセス方法： CLASS_NAME::CONSTANT_NAME
    - 配列を併用した定義も可能
      - ARY=[A=1,B=2,C=3]
      - HOGE::A # 1
      - HOGE::ARY # [1,2,3]
    - mapや三項演算子も定義可能
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
  - scan:正規表現にマッチする部分を配列に入れて返す
  - [], slice:マッチした部分を抜き出す
  - 置換のgsub
    - 基本`'aa-bb'.gsub('-','=') # 'aa=bb'`
    - 第二引数にハッシュを渡す
      - `'aa-bb'.gsub(/a|b/,{'a'=>'c', 'b'=>'d'}) # 'cc-dd'`
    - 第二引数の代わりにブロックを渡す
      - `'aa-bb'.gsub(/a|b/){|m| m == 'a'? 'c':'d'} # 'cc-dd'`
    - 第二引数に\1\2を渡す(''で括るので注意)
      - `'My birthday is 1986/07/09, summer'.gsub(/(\d+)\/(\d+)\/(\d+)/,'\1-\2-\3')`
    - 第二引数ではなくブロックと$を渡す
      - `'My birthday is 1986/07/09, summer'.gsub(/(\d+)\/(\d+)\/(\d+)/) do "#{$1}-#{$2}-#{$3}" end`
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
  - 特異メソッド：変数hogeに対して`def hoge.foo xxx end`とするとhogeだけのメソッドを定義できる
- 配列
  - 作成：[*0..10]、（0..10).to_a
  - Array.new(5, 'default') # defaultを全要素が参照する
  - Array.new(5){'default} # defaultに個別の値が入る
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
  - 配列化(配列[]の中に範囲オブジェクトと\*を付加する)
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
      - IDが同じかを判別するのはequal?
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
  - 作成
    - //は/をエスケープする必要がある
      - /https:\/\/example.com/
    - %r{}はエスケープ不要
      - %r{https://example.com}
  - 存在有無確認
    - '123-4567' =~ /\d{3}-\d{4}/ # true
    - '123-4567' =~ /\d{3}-\d{1}/ # true
  - match
    - キャプチャ
      - /(\d+)年(\d+)月(\d+)日/としたときの()で括った箇所をキャプチャと呼ぶ
    - サンプルコード
      ```ruby
      text='私の誕生日は1977年7月17日です。'
      m=/(\d+)年(\d+)月(\d+)日/.match(text)
      # m=text.match(/(\d+)年(\d+)月(\d+)日/)でも同じ。matchはstringにも定義されているため
      # m[0]#=>"1977年7月17日" m[1]#=>"1977" m[2]#=>"7" m[3]#=>"17"
      ```
    - =~ やmatchを使用しただけで$の組み込み変数に値が代入されている
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

- Rubyでは全てのものがオブジェクトになる
- クラス宣言時に継承を記述しない場合はオブジェクトクラスが継承される
- 用語
  - クラスから生成されたもの：オブジェクトとインスタンスで同じ意味
  - レシーバ：メソッドを呼び出された側
  - 状態・ステート：オブジェクトが保持しているデータ
  - 属性・アトリビュート・プロパティ：get/setできるデータ
  - is-a
    - 継承が適切かの判断に使用できる。声に出して違和感がないこと
    - サブクラスはスーパークラスの一種である
    - rice is a food.
- クラス名は大文字で書き始める
- サンプルコード
  ```ruby
    class User
  		attr_accessor :name # 外部からアクセス可能になる
  		attr_reader :name # read only
  		attr_writer :name # write only
      def initialize(name)
        @name =name
      end
      def hello # インスタンスメソッド。user.helloで呼び出す
        puts "hello I am #{@name}!"
      end
      def self.bye # クラスメソッド。User.bye、User::byeで呼び出す
        puts "bye"
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
- オーバーライド
  - そのまま`def hoge`
  - メソッド内でsuperをcallすると親クラスのメソッドを呼べる
- 遅延初期化、メモ化：`||=`を使用すると重い処理でも初回のみ代入できるようになr
- 変数＠
  - @value :インスタンス変数：インスタンスに一つ持ち、外からアクセス可能
    - メソッド間で共有可能
  - @@value :クラス変数　　　：インスタンス共通＝クラスで一つ持ち、外からアクセス可能。子クラスでも共通
  - 英大文字 : 定数 : インスタンス共通で一つ持ち、外からアクセス可能class::const
- クラスメソッド
  - 定義例。`def self.discountDay?`
  - インスタンスを生成せずに呼べる
  - 対：インスタンスメソッド
- アクセス権限
  - publicデフォルト
  - private
    - 記載して改行してインテントした箇所が適用される
    - クラスメソッドはprivateにならない
      - privateにする場合
        - class << self endでくくる
        - private_class_method :your_method を定義後に宣言する
        - private :foo, :bar。この場合はprivate以下はprivateにならないので注意
    - 親クラスがprivateでもpublicでオーバーライドされる。親クラスがコールするとエラーになる
      - インスタンス変数もオーバーライド出来て値を書き換えてしまう
        - 継承元のクラスの構造をよく理解しておくことが重要
          - メソッドのオーバーライドで親のメソッドが書き変わらないのとは違う仕組み？
  - protected
    - protectedをメソッドかattr_readerの前に付加する
    - 定義したクラス自身とサブクラスのインスタンスメソッドからレシーバ付きで呼び出せる
    - ある情報を公開をしたくないがインスタンス同士で比較したい場合などに有効
- ファイル構造
  - プログラム実行部分：index.rb、その他のクラス：menu.rb
  - ファイルの読み込み`require "./menu"`
- ライブラリ
  - date

## Minitest

```ruby
require 'minitest/autorun'
class SampleTest < Minitest::Test # 継承する
  def setup
    # テスト前に必ず行う処理
  end
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

- 概要：メソッドや定数をまとめたもの
- 特徴：インスタンスの作成、継承がない
- 用途
  - 継承を使わずにクラスにインスタンスメソッドを追加する、もしくは上書きする（ミックスイン）
    - 実質多重継承の仕組みの提供
  - 複数のクラスに対して共通のクラスメソッドを追加する
  - クラス名や定数名の衝突を防ぐために名前空間を作る
    - モジュールの階層構造が可能
    - ファイル構成もフォルダ毎にmoduleの入れ子になる
    - moduleを宣言してその中にclassを定義する
    - 関連するメソッドや定数をまとめてスコープに置きたいとき
      - 宣言方法
      ```ruby
      # その1
      class ModuleA::Second
      end
      # その2
      module ModuleA
        class Second
        end
      end
      ```
      - 呼び出し方
        - ModuleA::Second.new
        - ModuleB::Second.new
- 使用方法
  - 呼び出し側でincludeする
  - 参照先ではpublicになるのでmodule定義時はprivateにしておく
  - 呼び出し時のコンテキストは呼び出し元(self)になる
    - 呼び出し元に変数やmethodがある前提で実装可
  - クラスでextendする
    - クラスメソッドとして使用可能になる

```ruby
# module.rb
# モジュールの定義
module Rainbowable
  def rainbow
    self.to_s.chars.each.with_index { |s, i|
      print "\e[3#{i%6+1}m#{s}"
    }
    puts "\e[0m"
  end
end
```

```ruby
# 使用側.rb
# モジュールをincludeして使用可能にする
String.include Rainbowable
# モジュールの使用
'abcdefg'.rainbow
```

```ruby
module modName
	# description
end
```

    - includeなどせずに単に使用する場合は`module_function`を付加する

## 例外

- railsには例外時の共通処理が組み込まれている
  - そのため初手でrescueを検討しない
  - 最初はログを残してそのままraiseするだけでも良いかもしれない
- ライブラリ側でリソースの自動クローズを提供していることが多い。そちらをまず検討する。オープン時にブロック付きで渡すメソッドが多い。

```ruby
retry_count = 0 # retry制御用　
begin # try
	raise ArgumentError.new("Invalid argument #{arg}") # throw
rescue ZeroDivisionError, NoMethodError
  puts '0 division or Not exists Error'
rescue => ex # catch
	puts ex.message # ZeroDivisionError
	puts ex.class   # divided by 0
	puts ex.backtrace
	puts ex.full_message
  retry_count += 1
  retry if retry_count < 3 # beginからretry
  raise # 同じ例外をそのまま上に投げる
ensure # finally
 puts "finally"
end
```

## ブロックとyield

- yieldでは渡されたブロックを実行する

```ruby
def greet
  puts '1'
  yield if block_given?
  puts '3'
end
greet
greet {puts '2'}
```

```ruby
# 引数として明示して受け取る場合
def greet(&block)
  puts '1'
  #puts yield(1)と同じだが、この場合は複数引数に対応できない
  puts block.call(1) if block_given?
  puts '3'
end
greet
greet {|s| s * 2}
```

# Proc

- Procクラスはブロックをオブジェクト化するためのクラス
- Procedureが由来
- ブロックをProcの変数に入れて扱うことができる
- 定義してからcallする

  ```ruby
  # Proc.newで生成
  add_proc = Proc.new {|a=0,b=2| a+b}
  # procで生成
  add_proc = proc {|a=0,b=2| a+b}
  # ラムダで生成
  add_proc = -> (a,b=2) {a+b}
  # ラムダで生成(非省略形)
  add_proc = lambda{|a=0,b=2| a+b}

  # 使用
  add_proc.call(1) # 3
  ```

- JavaScriptの関数と同等

  ```javascript
  addProc = (a, b) => a + b;
  addProc(1, 2);
  ```
  - モジュール内に引数ありで定義する例
  ```ruby
  module  Effects
    def self.echo(rate) = -> (words) {
      words.chars.map{|s| s== ' '? ' ': s * rate}.join
    }
  end
  ```

- 畳み込み演算のinject(initial_value)

```ruby
[1,2,3,4].inject(10){|result, n| result + n} # 20
```

# パターンマッチ

- 概要
  - フォーマットが微妙に異なるデータ群のデータ抽出や整形を行いやすくする仕組み
  - 変数に直接代入も可能
- 利用パターン
  - value: 値を直接記載する
  - variable: 変数で比較する。objと書くと全てにmatchする
  - array: 配列に対するパターン
    - 完全一致に適合
  - hash: hashに対するパターン
    - 部分一致に適合＝inで指定したキーが存在すれば他のキーの有無は判定に含まれない
      - 上から順に評価される
  - as: in {name:String => name, age:18.. => age}のように書いて変数に代入する
  - alternative: in 1|2|3 のように記載し、どれか一つに当てはまればmatch
    - variableとの組み合わせは不可
  - find:
    - case [1,1,1,11,12,13,2,2,2]
    - in [*, 10..=>a, 10..=>b, 10..=>c, *]
    - 前後の*は任意として10以上の整数が連続する部分を抜き出して代入する
    - Ruby3.2から正式対応
- inの一番外側の[]と{}は省略可能
- 注意点
  - スコープがないので
    - 同名の変数があれば上書きされる
    - パターンマッチを抜けてもアクセス可能
- One-line pattern match(1行パターンマッチ)もある
  - Ruby3.1から正式対応
```ruby
# caseを省略した一行のif文
person = {name: 'Alice', children: ['Bob']}
if person in {name:, children: [_]}
  # match
end
```
```ruby
# selectで条件に合うハッシュのみ取得
persons = [
  {name: 'Alice', age: 11, gender: 'female'},
  {name: 'Bob',   age: 12, gender: 'male'},
  {name: 'Carol', age: 13, gender: 'female'},
]
persons.select { |p| p in {gender: 'female'} } => females # 右代入 
puts females
```

- 応用した変数代入（）右代入とも呼ばれる
  - `式 => パターン`
  - `123 => n`
  - メソッドチェーンの結果を代入することに用いられる

```ruby
# 配列
require 'date'
dates = 
  # records
  [
    [2021],
    [2022,5],
    [2023,11,22],
  ]
  .map do |record|
    case record
    # 要素のマッチ
    in [y]
      Date.new(y,1,1)
    in [y,m]
      Date.new(y,m,1)
    in [y,m,d]
      Date.new(y,m,d)
    end
end
puts dates
```
```ruby
cars=[
  {name:'TheBeatle',engine:'105ps'},
  {name:'Prius',engine:'98ps',motor:'72ps'},
  {name:'Tesla',motor:'306ps'}
]
car2 = cars.each do |car|
  case car
  # シンボルで指定
  in {name:,engine:,motor:}
    # シンボルと同名のlocal変数に代入される
    puts "Hybrid:#{name}/engine:#{engine}/motor:#{motor}"
  in {name:,engine:}
    puts "Gasoline:#{name}/engine:#{engine}"
  in {name:,motor:}
    puts "EV:#{name}/motor:#{motor}"
  end
end
puts car2
```

## ツール
- Brakeman:セキュリティチェック
- RuboCop: コーディング作法
- Rake
  - 元はビルドツール。Rubyで作られている。MakeのRuby版
  - 今はタスクを実行できるツール
  - テストコードの一括実行など
    - Rakefileを記載して`rake`を実行する
    ```ruby
    require 'rake/testtask'
    Rake::TestTask.new do |t|
      t.pattern='test/**/*_test.rb'
    end
    task default: :test
    ```
- Bundler
  - gemの管理
    - 同一バージョンをコマンド一つでインストール
    - 流れ
      - bundle init
        - Gemfile、Gemfile.lockが作成される
          - Gemfile.lock: Bundlerで管理すべきgemとそのversionが記載される
      - Gemfileに使いたいgemを記載:`gem faker, '3.2.2`
      - bundle install
      - bundle exec ruby sample.rb
    - bundle exec rubyで実行した場合はgemに記載されたversionで実行される
      - 単純にrubyで実行した場合はそのその環境にインストールされている最新のものが実行される

## 型情報の定義と型検査
- 下記を使用して.rbはそのままで外部から型づけを実現している
  - RBS
    - Rubyの型情報を扱う言語
    - .rbとは別の.rbsファイルに型情報のみ記述される
  - TypeProf
    - .rbを解析して.rbsを生成するツール
  - Steep
    - 型検査器

## Railsと素のRubyの違い
- requireをrailsでは書く機会が減る。フレームワークが行ってくれるため。
- ディレクトリ構造から名前空間を判別してmoduleが自動生成される
- 標準ライブラリやMinitestが拡張されている
  - 'HelloWorld'.underscore #=> "hello_world"