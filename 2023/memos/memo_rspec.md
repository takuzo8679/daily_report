# RSpec

## 方針

- TDDにすべき
-

## 実装

- 自然な文になるようにdescribeとitを記載する
  - 例ユーザーは文字列としてユーザーのフルネームを返す
- describe
  - 期待する結果をまとめて記載する
  - 「ユーザーは」などの主語を書く
  - クラスやシステムの機能の大枠を記載する
- context
  - 実装上はdescribeと同等になる
  - 特定の状態を記述する
    - 例えば結果が返ってくる状態と返ってこない状態の二つ
- it
  - 一つにつき結果を一つだけ期待する
  - 問題が起きたバリデーションを特定するため
  - is valid のように動詞を書く
- 方針
  - 期待する結果を能動系で明示的に記述する
  - 起きてほしいこと、起きてほしくないことを記載する
  - 境界値をテストする

## 設定

- .rspec
  - --format documentation:見やすくなる
  - --warning:警告表示

### database

- bin/rails db:create:all # db作成

### rspec

- bin/rails generate rspec:install
- conif/application.rbの設定

  - generate:
    - .rspec：設定ファイル
    - spec/：スペックファイル格納
    - spec/spec_helper.rb：ヘルパー
    - spec/rails_helper.rb：ヘルパー

- bundle exec rspec #実行
- bundle binstubs rspec-core # 実行用ファイル生成
