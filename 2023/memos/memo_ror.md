# Ruby On Rails メモ

## railsコマンド
### アプリ初期化
- `rails new tweet_app`:必要ファイル生成
- `rails server`:server起動
- `rails generate controller home top`:/home/topにトップページ作成
    - homeというコントローラーが作成されるので一度しか使えない
    - ページを追加する際は　controller.rbとroutes.rbにアクションを追加する
    - 
### Database
- マイグレーションファイル作成
    - `rails g model Post content:text`を実行
        - g:generateの短縮
        - Post' postsテーブルを作成する際は先頭おおもじの単数系にする
        - content:column
        - text:データ型
    - 作成場所
        - migration:`/db/migrate/20230831235959_create_posts.rb`
        - model:`app/models/post.rb`
    - 実行:`rails db:migrate`
        - DB未反映のマイグレーションファイルがあるとRailsがエラーになるので注意
- ``:
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
    - `post = Post.find_by(id:1)` // id検索
- データ編集
    - `post = Post.find_by(id: :id)`
    - `post.content = "new message"`
    - `post.save`
- データ削除
    - `post.destroy `
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
    - サイト全体に表示される共通のレイアウトのHTML
        - `views/layouts/application.html.erb`
        - `<body>`タグの`<%= yield %>`に配下のerbが代入される仕組み
    - フォームからデータを送信
        - `<%= form_tag("/posts/create") do %>`　でくくる。doを忘れずに
            -  `<textarea name="content"></textarea>`
                -  textareaタグにname属性を指定する
                -  name属性の値をキーとしたハッシュがRails側に送られる
            -  `<input type="submit" value="投稿"` inputボタンで送る
        - `<%end%>`　で締める
    - POSTメソッドでリンクする
        - `<%= link_to("削除", "/posts/#{@post.id}/destroy", {method: post})%>`
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
    -  controllerは目的に合わせて作成する
    -  リダイレクト:`redirect_to("/posts/index")`
    -  
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

- ``:
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
