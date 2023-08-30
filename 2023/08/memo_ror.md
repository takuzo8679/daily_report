# Ruby On Rails メモ

## アプリ初期化
- `rails new tweet_app`:必要ファイル生成
- `rails server`:server起動
- `rails generate controller home top`:/home/topにトップページ作成
    - homeというコントローラーが作成されるので一度しか使えない
    - ページを追加する際は　controller.rbとroutes.rbにアクションを追加する
    - 
- ``:
- ``:
## 基礎知識
### view/controller/routing
- view
    - 実体は`app/views/home/top.html.erb`
    - htmlのようなもの
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
- routing
    - `app/config/routes.rb`
    - URLからどのコントローラの、どのアクションで処理するかを決める対応表
    - home/viewならhomeコントローラーのtopアクション
### レイアウト
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
