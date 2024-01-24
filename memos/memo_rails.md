# Ruby On Railsメモ

## 概要

- 設定より規約：CoC Convention over Configuration
  - 規約に則った記載をすることで設定を自動で行う
    - 例。ModelName: User -> TableName: users
      - 大文字始まり単数形小文字複数形
- DRY:共通処理の集約
- MVC

## 環境

- gem -v
- gem install rails -v 7.0.0 -N
  - -Nドキュメントをインストールしないオプション

## railsコマンド

### アプリ初期化

- `rails new tweet_app`:必要ファイル生成
  - rails _7.0.0_ new helloとversionを指定することもできる
- `rails server`:server起動
- `rails generate controller home top`:/home/topにトップページ作成
  - homeというコントローラーが作成されるので一度しか使えない
  - ページを追加する際は　 controller.rbとroutes.rbにアクションを追加する
  - viewが不要な場合は手動作成可能
  - 必要なものを選択することが可能
    - `rails g controller comments create destroy --skip-template-engine`

### Database

- マイグレーションファイル作成
  - モデルも作成
    - `rails g model Post content:text user_id:integer`を実行
      - g:generateの短縮
      - Post
        - 作成するモデル名。先頭大文字の単数系であることに注意
        - postsテーブルが作成される
      - content:column
      - text:データ型で長い文字列。sting:短い文字列
      - 他の例：`rails g model User name:string email:string`
        - モデル名が大文字始まりの単数系であることに注意
    - 作成場所
      - migration:`/db/migrate/20230831235959_create_posts.rb`
      - model:`app/models/post.rb`
  - マイグレーションファイル作成のみ
    - `rails g migration your_file_name`
  - column追加
    - `add_column :テーブル名, ;カラム名, :データ型`
    ```ruby
    def change
        add_column :users, :image_name, :string, null: false, limit: 30, unique:true
    end
    ```
  - save,update,createの違い
    - save:オブジェクトを現状通りに登録・更新する
    - update:変更内容を引数で指定して更新する
    - create:オブジェクトを生成してからsaveする
  - unique:trueでもnullは異なる値となる
  - 細かい指定はmodelのvalidateを使う
- マイグレーション
  - 実行:`rails db:migrate`
    - DB未反映のマイグレーションファイルがあるとRailsがエラーになるので注意
    - 動作確認:`rails db:migrate:redo`:今の状態を一旦下げてから元に戻す
  - ロールバック:`rails db:rollback`
    - 実行前に戻す
    - コードによっては戻せない場合もありその時はエラーになる
  - アプリケーションコードでマイグレーションを書かない
    - `User.all.find_each { |user| user.update(admin: false) }`とするとUserクラスの実装に依存してマイグレーション実行タイミングではクラスが変更されて動かない場合がある
      - `each`:取得した件数の分だけインスタンスを生成するので大量のメモリが取得される
      - `find_each`:1000件ずつ分割して実行される
    - `class Table < ActiveRecord::Base; end`のようにしてTableクラスからupdateを実行できる。これでアプリコードと分離できる
  - マイグレーションで例外が発生した場合はrallbackされる
  - マイグレーションでのメソッドは!を使用する
    - update  :失敗時にfalseを返す(save, create, destroyも同様)
    - update! :失敗時にraiseする
  - ActiveRecordにはキャッシュが存在する
    - アクセス頻度を下げる仕組み
    - 連続で更新する場合は最初の状態で取得した状態に更新をかけるので不正な状態になる場合がある
    - update実行前に`reset_column_information`でキャッシュをリセットする
    - `Table.reset_column_information`
  - マイグレーションファイルが多くなったらSquasherというgemで一つに集約が可能
- DB管理画面
  - 起動:rails db、またはrails dbconsole
  - table一覧：.schema
  - 終了: .exit

### Gemfile

- インストール手順
  - Gemfileに追記：`gem bcrypt`
  - ターミナル：`bundle install`

### rails console

- `rails console`で起動、`quit`で終了
- データ作成
  - Task.create(title: 'test1')

## DB操作

- データ作成
  - `post = Post.new(content: "Hello world")` // インスタンス作成
  - `post.save` // Postテーブルに保存
- データ取得
  - `post = Post.first` // 最初のデータを取得(インスタンスとなる)
    - `post.content` // 中身が取り出せる
  - `posts = Post.all` // すべてのデータを取得(インスタンス配列となる)
    - `posts[0].content` // 中身が取り出せる
    - 並べ替え
      - `@posts = Post.all.order(created_at: :desc)`
      - byが付かないorder, 小文字シンボルのdesc
  - 検索
    - 1件：`post = Post.find_by(id:1, password:"xxx")` // id & pass検索
    - 複数：where
- データ編集
  - `post = Post.find_by(id: :id)`
  - `post.content = "new message"`
  - `post.save`
- データ削除
  - `post.destroy `
- データカウント
  - `Like.where(id:1).count`

## view/controller/routing

- view
  - 実体は`app/views/home/top.html.erb`
    - Embedded Ruby:埋め込みRubyの略
  - htmlのようなもの
  - リンク
    - `<a href="/">TweetApp</a>`
    - `<%= link_to("表示文字", "/your/path")%>`
      - =を忘れずに
      - パスの頭の/を忘れずに
    - `<%= link_to("表示文字", "/your/#{post.id}")%>`
  - 組込みruby
    - `<%%>`でくくる
      - 例：`<% post1 = "This is Variable" %">`
        - %%で括られた箇所がRubyのコード
    - 表示
      - `<%=%>`とイコールをつける
      - `<%= post1 %>` // This is Variableを表示
      - `<%= @posts.each do |post| %>` // 間違い。処理を実行しつつ@postの中身も表示されてしまう
      - `<%%>`内にタグは書けない。`do`と　`<%end%>`で複数行にする
  - サイト全体に表示される共通のレイアウトのHTML
    - `views/layouts/application.html.erb`
    - `<body>`タグの`<%= yield %>`に配下のerbが代入される仕組み
    - controllerで定義した変数・共通変数を受け取れる
  - フォームからデータを送信
    - rails7からは`form_with`を使う
      ```html
          <%= form_with model: item, url: admin_items_path do |f| %>
            <% if item.errors.any? %>
              <div class="alert alert-danger" role="alert">
                <ul>
                  <% item.errors.each do |error| %>
                    <li><%= error.full_message %></li>
                  <% end %>
                </ul>
              </div>
            <% end %>
            <div class="mb-3">
              <%= f.label :name, class: "form-label" %>
              <%= f.text_field :name, required: true, class: "form-control" %>
            </div>
            <div class="mb-3">
              <%= f.label :price,  class: "form-label" %>
              <%= f.number_field :price, required: true, step: "0.01", min: 1, max: 1000, required: true, class: "form-control" %>
            </div>
            <div class="mb-3">
              <%= f.label :description, class: "form-label" %>
              <%= f.text_area :description, required: true, class: "form-control"  %>
            </div>
            <div class="mb-3">
              <%= f.submit "Add New Item", class: "btn btn-dark"%>
            </div>
          <% end %>
      ```
    - 以降はrails5
    - `<%= form_tag("/posts/create") do %>`　でくくる。
      - do,=を忘れずに
      - `<textarea name="content"></textarea>`
        - textareaタグにname属性を指定する
        - name属性の値をキーとしたハッシュがRails側に送られる
      - `<input type="submit" value="投稿"` inputボタンで送る
      - 画像を送るとき
        - `<%=form_tag("/login", {multipart: true}) do %>`
        - `<input name="image" type="file">`
    - `<%end%>`　で締める
  - POSTメソッドでリンクする
    - `<%= link_to("削除", "/posts/#{@post.id}/destroy", {method: "post"})%>`
  - 画像表示
    - `<img src="<%="/user_images/#{@user.image_name}"%>`
      - `=`がつく
      - `/`で始まる
      - `"`が二箇所はいる
- controller
  - 実体は`app/controllers/home_controller.rb`
  - controllerを経由してviewをブラウザに返している
  - `rails generate controller home top`を実行すると
    - 上記が作成される
    - その中に`top`というメソッドが作成される
    - コントローラ内のメソッドをアクションと呼ぶ
    - アクションの動き
      - コントローラと同じ名前のビューフォルダを探す
      - アクションと同じ名前のHTMLファイルを探す
        - `views/home/top.html.erb`
      - ブラウザに返す
    - viewで使用する変数はアクション内に定義する
      - @posts=[...]のように@をつけることでviewなどで使用可能になる
        - インスタンス変数にしてやる
      - viewでも@をつけて使用する
    - URL内のパラメータの取得方法
      - `posts/:id`とした場合、`@id=params[:id]`で取得できる // paramsに@はいらない
      - .html.erbでは　`<%=@id%>`とする
        - `<%="idは「#{@id}」です"%>`
    - formから送られるデータの取得
      - view側でタグ：`name="xxx"`としておき
      - controller側は`a = params[:xxx]`で受け取る
  - controllerは目的に合わせて作成する
  - 共通処理
    - controllerファイル内で共通の処理
      - `before_action :set_current_user, {only: [:edit, :update]`のようアクションで記載する
      - onlyで対象のアクションを選べる
    - 全てのcontrollerで共通する処理は`application_controller.rb`に記載する
      ```ruby
      class ApplicationController < ActionController::Base
          before_action :set_current_user
          def set_current_user
              @current_user = User.find_by(id: session[:user_id])
          end
      end
      ```
  - リダイレクト
    - 別のrouteに飛ばす
    - `redirect_to("パス")`
    - `redirect_to("/posts/index")`
    - `redirect_to controller_name_path # URIヘルパーを使用`
    - /をつける。ファイルではなくパスなので。
  - ビュー表示
    - 別のアクションを介さずにxx.html.erbを表示する
    - `render("ビューファイル")`
    - `render("posts/edit")`
      - /はつけない。routeではなくファイルなので
  - フラッシュ
    - 投稿成功時など1度だけ表示させたいメッセージ
    - \_\_.controllerにてflash変数に代入`flash[:notice] = "hoge"`
      - または`redirect_to boards_path, flash: {notice: "hoge"}`
    - \_\_.html.erbにてflash変数がある場合に表示
    - ```erb
      <%if flash[:notice]%>
          <div class="flash>
              <%=flash[:notice]%>
          </div>
      <%end%>
      ```
- routing
  - `app/config/routes.rb`
  - URLからどのコントローラの、どのアクションで処理するかを決める対応表
    - `get "top" => "home#top"`でGET /topのURLで　 home_controllers.rbのtopアクションにroutingする
    - `get "/" => "home#top"`でGET / のURLで　同上
  - home/viewならhomeコントローラーのtopアクション
  - ルーティングは上から順に探していく
  - URLにidを含める:`get "posts/:id" => "posts#show"`とすると　 1でも2でもshowへ行く
    - `:id`はpost内の末尾に書く
  - `resources :tasks`と記載すると関連するCRUDを自動生成してれる
  - | Prefix    | Verb   | URI Pattern     | Controller#Action |補足           |
    | --------- | ------ | --------------- | ----------------- |---------------|
    | tasks     | GET    | /tasks          | tasks#index       |一覧の取得       |
    |           | POST   | /tasks          | tasks#create      |新規追加         |
    | new_task  | GET    | /tasks/new      | tasks#new         |追加用の画面取得   |
    | edit_task | GET    | /tasks/:id/edit | tasks#edit        |編集用の画面取得   |
    | task      | GET    | /tasks/:id      | tasks#show        |詳細の取得        |
    |           | PATCH  | /tasks/:id      | tasks#update      |編集実行          |
    |           | PUT    | /tasks/:id      | tasks#update      |PATCHと違いはない  |
    |           | DELETE | /tasks/:id      | tasks#destroy     |削除              |

## レイアウト

- フォルダ構造
  - app: application main
    - assets: image, style sheet, JavaScript
      - images
      - javascripts
      - stylesheets
        - home.scss: generateコマンドで生成される
        - 全てのviewに提供される

## app/model

- バリデーション
  - 書き方
    ```ruby
    class Post < ApplicationRecode
        #  　　検証するカラム名, 検証内容(値の存在確認)
        validates :content, {presence: true}
        # 複数入力する場合は,で区切る {___: ___, ___:___  }
    end
    ```
  - :の位置に注意する
  - 文字数制限: `validates : content, {length: {maximum: 140}}`
  - 重複禁止：`{uniqueness: true}`
  - ヘルパーにないものは作成する
    - メソッドを追加
    - 自前のvalidatorを追加

## ライブラリ

- ファイル操作
  - 書き込み
    - テキストファイル
      - `File.write("public/sample.txt", "your contents")`:
      - publicフォルダに格納する例
    - 画像ファイルはバイナリで書き込む
      - `File.binwrite("public/image_name", image.read)` # image.readはファイルの中身
- ログイン機能
  - viewのinputのタグで`type="password"`と指定する
  - ログイン画面を追加
  - マイグレーション
  - フォームの値の送信
  - email/passをfind_by検索
  - ログイン処理
    - セッション
      - `session[:yourKey] = value` とするとブラウザに保存される
  - ログアウト
    - セッションを削除:`session[:yourKey] = nil`
  - サインアップ時の処理
- アクセス制限
  - 各controller.rbで制限をかける
    - application_controller.rbで定義しておく
    - `if @current_user == nilならredirect("/login")`
  - `before_action :authenticate_user, {only: [:edit, :update]}` // onlyで適用範囲を指定する
  - application_viewで表示項目を切り替える
  - viewで一致ユーザーのみ編集リンクを表示する
- いいね機能
  - Likeテーブルを作成する
    - user_id, post_id
  - いいねアイコンはFont Awesomeから取得
- パスワードハッシュ化、ユーザー認証
  - `bcrypt`をインストール
  - `password_digest`カラムを追加し、`password`カラムは削除
  - `has_secure_password`をモデルファイルの上部に記載
    - `authenticate`などのメソッドが使えるようになる
  - `models/users.rb`のpasswordのvalidationを削除
  - 保存
    - → 今まで通りpasswordを操作するだけでハッシュ化してpassword_digestに代入してくれる
  - 検証
    - emailなどで@userを取得後に
    - `if @user && @user.authenticate(params[:password])`
- 検索とソート
  - ransackというgemで検索とソートが行える
- Action Mailer
  - Rails標準のメイラー機能
  - 動作確認にはmailcatcherというgemが使える
    - `mailcatcher`というコマンドでsmtpサーバーがたつ
  - RSpecでもテスト可能
- Active Storage
  - Rails標準gem
  - S3へファイルをアップロードしてDB上でActiveRecordモデルに紐づけられる
  - 画像のサイズやフォーマット変換、プレビュー機能も提供
- Active Job
  - 非同期処理や定期実行

## Bootstrap

- 使用の流れ
  - gemに追加
    - bootstrap:本体
    - sassc-rails: sass
    - mini_racer: jsを使用するためのgem
  - (bundle install(docker build)が必要)
  - 予め用意されている`app/assets/stylesheet/application.css`の拡張子を`.sass`に変更
    - 記載されているrequireを削除して`@import bootstarp`を追加
  - ここまででbootstrapのstyleが適用されるようになる
  - bootstrap関連のjsの読み込み設定
  - import_map
    - javascriptのライブラリの名前と実際のファイル名を関連づけるもの
      - Bootstrapのテンプレート上のコードでjsが実行される時にgemに含まれるjsを見にいくようにする
    - コマンド実行：`rails importmap:install`
      - 初期ファイルが自動で作成される
        - config/importmap.rb
          - `pin "bootstrap", to: "bootstrap.min.js", preload: true`
            - `import bootstrap`と記載すると`bootstrap.min.js`が読み込まれるようになる
              - bootstrap.min.jsはbootstrapのgemに含まれている
            - `preload: true`: jsが実行されるよりも前に読み込むことで実行時遅延を回避する
        - config/initializers/assets.rb
          - `Rails.application.config.assets.precompile += %w(bootstrap.min.js popper.js)`
          - アセットパイプラインの指定
            - ブラウザ読み込みのためにプリコンパイルで圧縮される
        - app/javascript/application.js
          - ここに読み込み時のコードを記載
            - bootstrapは画面読み込み時に動作を指定しないと動かない（`window.onload`）

## テスト/Rspec

- 導入(rspecの公式を参照)
  - Gemfile
    - gem 'rspec-rails', '~> 6.1.0'
    - （追記したらbundle install
  - 設定ファイルのインストール
    - rails g rspec:install
- テストファイルの追加
  - gコマンドを使う場合
    - `rails g rspec:model User`
    - `rails g rspec:controller Users`
      - 'request'フォルダ配下にコードが生成される
  - 使わなくても良い
- テストの実行
  - `rspec [-f d] ./spec/models` # -f dオプションで出力を整形
- テストの書き方
  - controllerはrequestという形式に変わっている
  - letは下の行に書くこともでき、その場合は上の行を上書きする
  - shared_example：重複するitを再利用する
- サンプル
```ruby
# テストコード
require 'rails_helper'
# 他のimportはいらない。フォルダ構成から読み取られる

#テストする対象
RSpec.describe User, type: :model do
  describe '#age' do
  # jestのbeforeEach
  before do
    # mock化：Time.zone.now(今)にアクセス時のreturn値を設定
    allow(Time.zone).to receive(:now).and_return(Time.zone.parse('2018/04/01'))
  end
    # テストケース。context内は共通のコンテキストになる
    context '20年前の生年月日の場合' do
      # テストの前提を設定。userモデルのnew時の値を設定
      let(:user) { User.new(birthday: Time.zone.now - 20.years)}
      # テストの実施
      it '年齢が20歳であること' do
        expect(user.age).to eq 20
      end
    end
    # テストケースその2
    context '10年前に生まれた場合でちょうど誕生日の場合' do
      let(:user) { User.new(birthday: Time.zone.parse('2008/04/01')) }
      it '年齢が10歳であること' do
        expect(user.age).to eq 10
      end
    end
  end
end
# 実行結果
# User
#   #age
#     20年前の生年月日の場合
#       年齢が20歳であること
#     10年前に生まれた場合でちょうど誕生日の場合
#       年齢が10歳であること
```

- Capybara
  - E2Eテスト（Systemテスト）用フレームワーク
  - railsに同梱されている
- FactoryBot
  - テスト用データの作成gem

## 環境構築

- `bin/setup`:初回
- `bin/update`:git pull後に環境を最新にするもの
- seedも運用する
  - 上記はメンテが漏れやすい

## JavaScriptとの関係

- 2パターン
  - 基本はRailsを使用してJSで補う。画面遷移のない動作など
    - マウスオーバーなどの変化をつける
    - Ajaxを用いた非同期処理(rails-ujsが活躍)
  - 基本はJSを使用してRailsはサーバサイドのみを提供
    - webpackerを用いたReact
- Turbolinks
  - すべてのページ遷移を自動的にAjax化することで高速化する仕組み
    - プレビュー機能
      - 前回のキャッシュを一旦表示してAjax受信後に更新する
  - 制約なども発生するので無効化も検討する

## その他

- 省略記法
  - 文字列   %w[abc def ghi]
  - シンボル　%i[abc def ghi]
  - カンマで区切らないこと

- ストロングパラメータ
  - formのラベルなどはdevツール書き換え可能なので脆弱性がある
    - そのままモデル層に渡すと不正なカラムの下記ができる
  - ストロングパラメータを使用することで意図してブロックする

```ruby
    def create
        p task_params #正しい場合はそのまま通り、不正の場合はエラーとなる
    end
    private
    def task_params
        params.require(:task).permit(:title)
    end
```

- turbo
  - Rails7から導入された非同期通信の仕組み
  - JavaScriptが不要になる
- パーシャルによるビューの再利用
  - _from.html.erbのように先頭にアンダースコアをつける
  - erbから読み込む
    - `<%= render partial: 'form', locals: { board: @board } %>`
  - 名称が同じ場合の省略形
    ```ruby
    <%= render partial: 'board', locals: { board: @board } %>
    <!-- 変数名が同じ場合はobjectに省略できる -->
    <%= render partial: 'board', object: @board %>
    <!-- ファイル名も全て同じ場合は更に省略できる -->
    <%= render @board %>
    ```
- タイムゾーン設定
  - config/application.rbに`config.time_zone = Tokyo`を追加
    - スレッドセーフになっているのでリクエスト毎に変えても他のリクエストに影響がない
  - config/application.rbに`config.active_record.default_timezone = :local`
    - と設定するとサーバーがある場所でDBに保存される（デフォルトは:utc)
- 言語設定
  - config/application.rbに`config.i18n.default_locale = :ja`を追加
  - config/localesにja.ymlを追加して下記のように記載
    ```yml
    ja:
      views:
        pagination:
          first: "最初"
          last: "最後"
    ```
- `link_to 'delete', hoge, method: :delete`でGETが呼ばれてしまう
  - Rails7からTurboLinkの仕様が変わったことが原因
  - 対応：button_toに変えると
  - 補足
    - link_toではGETを使用するaタグが生成される
    - button_toではvalue="delete"のinputを要素に持つのformタグ(method="post")が生成される
    - `<%= button_to "Add new Item", new_admin_item_path, method: :get, class: "btn btn-dark"%>`
- 初期データの投入
  - db/seeds.rbにコードを記載する
    ```ruby
    if Rails.env == 'development'
      (1..50).each do |i|
        Board.create(name: "ユーザー#{i}", title: "タイトル#{i}", body: "本文#{i}")
      end
    end
    ```
  - 重複登録の回避としてデータがなければ登録する`find_or_create_by!`
  ```ruby
  User.find_or_create_by!(email: 'admin@example') do |user|
    user.name = 'admin' 
    user.password = 'password' 
    user.password_confirmation= 'password' 
  end
  ```
  - コマンド実行
    - `docker-compose exec web bundle exec rake db:seed`
- ページネーション
  - kaminariをGemfileに追加する
  - 設定用のコマンドを実行する
    - `docker-compose exec web bundle exec rails g kaminari:config`
      - 作成される：`config/initializers/kaminari_config.rb`
  - kaminari用のビューファイルの作成
    - `docker-compose exec web bundle exec rails g kaminari:views bootstrap4`
      - `app/views/kaminari/`配下にパーシャル用のビューが作成される
  - 取得時の実装(index)
    - controller
      - 上記の設定をしたことにりApplicationControllerにpageメソッドが追加されている
        - 前：`@boards = Board.all`
        - 後：`@boards = Board.page(params[:page])`
    - view
      - 末尾にpaginateを追加するだけ
      - `<%= paginate @boards %>`
- アノテーション
  - データベースのテーブル情報をモデルのファイルに書き足してくれる
    - Gemfileに追加:annotate
    - `docker-compose exec web bundle exec annotate`
      - 上手くいかない場合は下記を実行
        - `docker-compose exec web rails g annotate:install`
          - 作成された lib/tasks/auto_annotate_models.rake ファイルを開く。
          - `show_indexes`をtrueからfalseにかえる
      - migrationでテーブルが作成される際にアノテーションの自動追加
        - `docker-compose exec web rails g annotate:install`
- アソシエーション
  - テーブルのキーの関連付け
    - モデル作成時のコマンドにオプション追加で行う
      - `bundle exec rails g model comment board:references name:string comment:text`
    - モデル生成時に`column_name:references`と入力するとBoardモデルと紐づけるためのboard_idカラムが作成される
    - 一の方
      - モデルファイルに`belongs_to: :table_name`が付加されている
      - 単数系になる
    - 多の方
      - モデルファイルに`has_many: :table_name(s)`を自分で付加する
      - 複数形になる
    - 多対多
      - 中間テーブルに対してthrough:を付加する
        - `has_many :table1(s), through: :table2(s)`
          - table2を介してtable1に多をもつ
    - タグ検索の場合
      - `@boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all`
        - tag_idがあればそれでTagテーブルから指定のboardsを取得してなければ全件取得
          - 全件取得だが、実際には@boardsが参照されるタイミングで全件取得になる
            - `@boards = @boards.page(params[:page])`
            - のようにしておけばpageの件数しかアクセスされない
  - dependent
    - 依存をするキーを自動で消す設定
      - 例えば掲示板とタグが多対多の場合にあるタグが消されたら掲示板テーブルの全レコードでそのタグを消す必要がある。データが浮いてしまうため。掲示板が消された時も同様。
    - Railsではdependentオプションで自動で行ってくれる
      - destroyメソッドが呼ばれた時のみ有効でdeleteでは効かない点に注意
      - `has_many :tag, dependent: :delete_all`
        - delete_allの他にdestroyもある
          - 頻度は低く通常はdelete_allを使用する
          - オブジェクト一つ一つに対してdestroyを実行する
          - 関連の関連を消すときなどに使用
- ログ
  - サンプル
    - `logger.debug 'error message'`
- 本番環境
  - アセットのプリコンパイルが発生する
  - master.keyの取扱に注意

## 設計手法

- MVC毎に共通化の手法がある
  - 階層違いのコードはないことが前提
- コントローラがシンプルなCRUD実装時と同様にコーディングできていると良い
- クラスによる共通化は性質に限る
- 処理の共通化はモジュールに移す
- 肥大化や何でも屋は避ける
- ActiveModel：クラス化する際に有用なサブモジュール群
