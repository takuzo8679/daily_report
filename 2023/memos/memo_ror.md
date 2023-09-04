# Ruby On Rails メモ

## railsコマンド
### アプリ初期化
- `rails new tweet_app`:必要ファイル生成
- `rails server`:server起動
- `rails generate controller home top`:/home/topにトップページ作成
    - homeというコントローラーが作成されるので一度しか使えない
    - ページを追加する際は　controller.rbとroutes.rbにアクションを追加する
    - viewが不要な場合は手動作成可能
### Database
- マイグレーションファイル作成
    - モデルも作成
        - `rails g model Post content:text`を実行
            - 他の例：`rails g model User name:string email:string`
            - g:generateの短縮
            - Post' postsテーブルを作成する際は先頭おおもじの単数系にする
            - content:column
            - text:データ型で長い文字列。sting:短い文字列
        - 作成場所
            - migration:`/db/migrate/20230831235959_create_posts.rb`
            - model:`app/models/post.rb`
    - マイグレーションファイル作成のみ
        - `rails g migration your_file_name`
    - column追加
        - `add_column :テーブル名, ;カラム名, :データ型`
        ```ruby
        def change
            add_column :users, :image_name, :string
        end
        ```
- 実行:`rails db:migrate`
    - DB未反映のマイグレーションファイルがあるとRailsがエラーになるので注意
### Gemfile
- インストール手順
    - Gemfileに追記：`gem bcrypt`
    - ターミナル：`bundle install`
### rails console
- `rails console`で起動、`quit`で終了
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
        - `<%= form_tag("/posts/create") do %>`　でくくる。
            - do,=を忘れずに
            -  `<textarea name="content"></textarea>`
                -  textareaタグにname属性を指定する
                -  name属性の値をキーとしたハッシュがRails側に送られる
            -  `<input type="submit" value="投稿"` inputボタンで送る
            -  画像を送るとき
                -  `<%=form_tag("/login", {multipart: true}) do %>`
                -  `<input name="image" type="file">`
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
        -  上記が作成される
        -  その中に`top`というメソッドが作成される
        -  コントローラ内のメソッドをアクションと呼ぶ
        -  アクションの動き
            -  コントローラと同じ名前のビューフォルダを探す
            -  アクションと同じ名前のHTMLファイルを探す
                -  `views/home/top.html.erb`
            -  ブラウザに返す
        -  viewで使用する変数はアクション内に定義する
            -  @posts=[...]のように@をつけることでviewなどで使用可能になる
                -  インスタンス変数にしてやる
            -  viewでも@をつけて使用する
        -  URL内のパラメータの取得方法
            -  `posts/:id`とした場合、`@id=params[:id]`で取得できる  // paramsに@はいらない
            -  .html.erbでは　`<%=@id%>`とする
                -  `<%="idは「#{@id}」です"%>`
        -  formから送られるデータの取得
            -  view側でタグ：`name="xxx"`としておき
            -  controller側は`a = params[:xxx]`で受け取る
    -  controllerは目的に合わせて作成する
    -  共通処理
        - controllerファイル内で共通の処理
            - `before_action :set_current_user`のようアクションで記載する
        - 全てのcontrollerで共通する処理は`application_controller.rb`に記載する
            ```ruby
            class ApplicationController < ActionController::Base
                before_action :set_current_user
                def set_current_user
                    @current_user = User.find_by(id: session[:user_id])
                end
            end
            ```
    -  リダイレクト
        -  別のrouteに飛ばす
        -  `redirect_to("パス")`
        -  `redirect_to("/posts/index")`
        -  /をつける。ファイルではなくパスなので。
    -  ビュー表示
        -  別のアクションを介さずにxx.html.erbを表示する
        -  `render("ビューファイル")`
        -  `render("posts/edit")`
            - /はつけない。routeではなくファイルなので
    - フラッシュ
        - 投稿成功時など1度だけ表示させたいメッセージ
        - __.controllerにてflash変数に代入`flash[:notice] = "hoge"`
        - __.html.erbにてflash変数がある場合に表示
        - 
            ```erb
            <%if flash[:notice]%>
                <div class="flash>
                    <%=flash[:notice]%>
                </div>
            <%end%>
            ```
- routing
    - `app/config/routes.rb`
    - URLからどのコントローラの、どのアクションで処理するかを決める対応表
        - `get "top" => "home#top"`で GET /top のURLで　home_controllers.rbのtopアクションにroutingする
        - `get "/" => "home#top"`でGET / のURLで　同上
    - home/viewならhomeコントローラーのtopアクション
    - ルーティングは上から順に探していく
    - URLにidを含める:`get "posts/:id" => "posts#show"`とすると　1でも2でもshowへ行く
        - `:id`はpost内の末尾に書く
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
        - `if @current_user == nil なら redirect("/login")`
    - `before_action :authenticate_user, {only: [:edit, :update]}` // onlyで適用範囲を指定する
    - application_viewで表示項目を切り替える
    - viewで一致ユーザーのみ編集リンクを表示する
- いいね機能
    - Likeテーブルを作成する
        - user_id, post_id
    - いいねアイコンはFont Awesomeから取得
- パスワードハッシュ化
    - `bcrypt`をインストール
    - `password_digest`カラムを追加し、`password`カラムは削除
    - `has_secure_password`を実行＝ファイルの上部に記載
        - `authenticate`などのメソッドが使えるようになる
    - `models/users.rb`のpasswordのvalidationを削除
    - 保存
        - →今まで通りpasswordを操作するだけでハッシュ化してpassword_digestに代入してくれる
    - 検証
        - emailなどで@userを取得後に
        - `if @user && @user.authenticate(params[:password])`
- ``:
## 
- ``:
- ``:
## 
- ``:
- ``:
## 
- ``:
- ``:
- 
