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

## テストデータ

- Fixture
  - Railsに最初からついている
  - ymlで記述
  - 別のファイルで管理される
  - 壊れやすい
  - ActiveRecordを使用しないので実環境と異なる
- Factory
  - コードをシンプルに保てる
  - 多用しすぎると遅くなる
    - 予期しないデータまで作成されていないか注意する
    - 可能な限りcreateよりもbuildを使用する
  - 記載例
    ```ruby
    #spec/factories/note.rb でデータ準備
    FactoryBot.define do
      factory :note do
        message { "My important note." }
        association :project # project作成時にuserが作成される
        # association :user # この記載では二重でuserを作成してしまう
        user { project.owner } # 上記のuserを関連付ける
      end
    end
    ```
    ```ruby
    #spec/models/note_spec.rb で作成
    it 'has a valid factory' do
      expect(FactoryBot.build(:note)).to be_valid
    end
    ```
  - build：インスタンス化のみでDBに保存しない
  - create:ActiveRecordを使用してDBに保存する
  - ユニークな値の生成:`sequence(:email) { |n| "tester#{n}@example.com" }`
  - associationによる関連付け
  - class, traitによる重複削除
  - create_list
  - コールバック: `after(:create) { |project| create_list(:note, 5, project: project)}`



