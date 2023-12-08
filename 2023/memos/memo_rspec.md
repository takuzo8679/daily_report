# RSpec

## 方針

- TDDにすべき

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
