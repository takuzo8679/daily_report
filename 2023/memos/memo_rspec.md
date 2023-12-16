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
- it
  - 一つにつき結果を一つだけ期待する
  - 問題が起きたバリデーションを特定するため
  - is valid のように動詞を書く
  - 

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
