# RSpec


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
- spec/rails_helper.rb
  - specのconfigの設定ファイル
  - なるべくきれいな状態を保たせて依存はsupportに移す
- spec/support/\*.rb
  - specのconfigの設定ファイル
  - rails_helperから読み込む

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

## controller

- 最近は他のテストを使うことを推奨(soft-deprecated)
- 対象となる機能の単体テストとして最善の場合のみ用いる
- 筆者はアクセス制御のテストに限定している（非認可とゲスト）
- コントローラのテストなのでUIは無視される
- 書き方はmodelと概ね同じでマッチャが異なる
- 使い過ぎると肥大化する傾向にあるので注意する
- APIパスはspecに紐づける必要がある(requestではない)

## system

- system specは時間がかかるので一つのシナリオで複数のexpectを書くのが良い
- controller specと異なりUIが考慮される
- テストの途中でexpectを書いても良い
  - ただしそれ専用のシナリオを書く方が良い
- Capybara
  - [DSL一覧](https://github.com/teamcapybara/capybara#the-dsl)
- ファイルアップロードテストではファイルの削除を忘れないようにする
- 外部APIを利用する場合はmockを使う

### 構文

- driven_by(:rack_test)
  - headless_driverの使用を宣言
    - 早くて高信頼だがJSは非サポートなので使用時は外す
- デバッグ用メソッド：コミットしないように注意する
  - save_and_open_page：　現在の状況をtmp/capybara/xxx.htmlに保存してブラウザで表示
  - save_page: 保存のみ

## request

- API関連のテストを行う
- Capybaraは不要なので使わない
- get, post, delete, patchでテストする
- ほぼcontroller specからの置き換えが可能
- controller specとの違い
  - 任意のpathを呼べる
  - routeからPOSTを送信する(createなどのアクションに作用するのがcontroller spec）

## dryに保つポイント

- support module
  - 毎回やる手順をワークフローを切り出す
  - テスト内容に焦点を当てて準備項目などを対象にする
    - 例えばログイン状態を作ることはテストの目的ではないのでdeviseを使う方が早い
- let
  - 遅延読み込み
  - let!で即座に作成する
  - beforeでは変数以外のメソッドなどを実行するとよい
- shared_context
  - 共通のセットアップを移動する
- カスタムマッチャ
- expectの集約
  - aggregate_failures:失敗したexpectを集約
  - エラーなど全ての失敗を集めるわけでない点に注意
- 可読性を上げる
  - シングルレベルの抽象化
    - コードを意味を持たせたメソッドに置き換える
    - https://thoughtbot.com/blog/acceptance-tests-at-a-single-level-of-abstraction

## 実行時間が速いテストの書き方、テストの速い(簡潔な)書き方

- RSpecの簡潔な構文
  - subject
    - testの対象物を宣言する
  - is_expected
    - ワンライナー記述用
    - これとShoulda Matchersの組み合わせでとても簡潔になる
- エディタのショートカット
- モックとスタブ
  - DBへアクセスしない
  - モック
    - 本物のフリをするdoubleクラス
    - `user = double(...)`または`user = instance_double(...)`
  - スタブ
    - オブジェクトのメソッドをオーバーライドする
    - `allow(some_class).to receive(some_method).and_return(something)`
    - allowの代わりにexpectを用いると検証に使える
    - each文の中でメソッドが呼ばれることを期待する例
      - `mock_object = instance_double(SomeClass)`
      - `allow(some_object).to receive_message_chain('aaa.bbb.ccc.each').and_yield(mock_object)`
      - `expect(mock_object).to receive(:ddd)`
        - mockではeachがないと言われることがあるのでその場合はreceiveに含めてand_yieldで返す
        - receive_message_chainのメソッドに引数を与えることはできない
        - 引数が含まれる場合はシングルクォーテーションでくくる（シンボルの可変長引数ではエラーになる）
  - テストが早くなる
  - コードの難易度は高くなるので無理に使用する必要はない
  - テストできる箇所も減る
  - 方針
    - なるべく検証付きテストダブルを使用する
      - そのままでは大元の変更に追従できなくなるため
    - 自分で管理していないコードをモック化しない
      - 変更に追従できなくなるため
      - 例外：ネットワーク、外部API
- タグ
  - つけたものだけを実行できる
  - 例：基本
    - `it "is valid", focus: true do`として
    - `$bundle exec rspec --tag focus`を実行
    - `$bundle exec rspec --tag ~focus`とすると指定タグ以外
  - 任意の名前でよい
  - describeやcontextタグにもつけられる
- 使用しないテストはskipでスキップできる

## その他のテスト

- Active Storage
- job:Active Jobをテストする
- Mailer
  - spy
    - メソッドが実際には実行されない（例えばメール送信)
    - テストコードが実行された後に発生したことを検証する(例えばuserの作成と作成時の挙動)
- VCR
  - 外部HTTPリクエストを監視する
  - 初回のrequestとresponseを記録してcassette
  - を作成する
  - 次回以降はこのcassetteを使用して外部との通信を模倣する
  - 内部でWebMockも使用する
  - gitにアクセスキーなどを含めないように注意する
    - サニタイズ用のオプションを使用する
  - cassetteが古くなる点に注意する
    - 定期的にcassetteを削除して再実行するとAPIの変更を早く検知できる

## TDD

- 手順
  - まず追加する機能を決める
    - 正常系とする
  - system specにscenarioを追加する
    - APIならrequest spec
  - 必要な手順をコメントで追加する
  - コメントをコードに置き換える
  - テストを実行する
  - エラーが出た箇所を実装していく
- TDDの信条
  - 一気に書きたい衝動があるが、テストを前進させる(エラーメッセージを変更させる)最小のコードを書くようにする
    - エラーが次に何をするべきか教えてくれる
- エラーケースはsystemより下層に記載する
- outside-in testing
  - TDDのアプローチ
  - まず表面的な機能（全体設計やアーキテクチャが最初）を実装し、その後にmodelやcontroller（詳細設計）を検討する
    - 反対がinseid-outで個々のコンポーネントから積み上げていく
- 正常系・異常系まで書けたらリファクタリングを検討する

## 最後のアドバイス

- 小さいテストから始める
- 書けない場合は小さいコードを書いても良いがテストもセットにする
- 複雑な場合はスパイク（アーキテクチャを確率するためのプロトタイプ）を活用する（別ブランチ、または新しいアプリ）
- system specから始める
  - ユーザーの手順を検討する
  - その途中で他のレベルでテストすべき手順が見つかる
    - validation, error case, authentication
- KISSを意識する
  - 複雑なspecを書くスキルにも繋がる
- 手作業に逃げない
  - 時間が節約されない
- リファクタリングを行う
- 周りに協力者がいない場合は教育する
- 練習を続ける