# Node.js

## Express

-   基本の書き方

    ```js
    const express = require("express");
    const app = express();

    // app.useは全pathで前処理される
    app.use((req, res, next) => {
        // ...
        // next(); //次の処理へ移す
    });

    //publicフォルダ内を読み込めるようにする
    app.use(express.static("public"));
    // ejsでの読み込み例(publicフォルダの下にcssフォルダがある前提)
    // `<link rel="stylesheet" href="/css/style.css">`

    app.get("/top", (req, res) => {
        // /topへのルーティング
        res.render("top.ejs"); //指定したejsを画面表示
    });
    ```

-   form の値の受け取る準備
    -   `app.user(express.urlencoded({extended; false}))`
-   SQL への引数の渡し方

    ```js
    connection.query(
        "UPDATE items SET name=? WHERE id = ?",
        [req.body.itemName, req.params.id], // ?の箇所に引数が渡される.配列で渡す。
        (error, results) => {}
    );
    -post処理後にrenderだと再読み込みで再postしてしまうのでredirectを用いる;
    ```

-   post でリクエストする際は入力項目がなくてもフォームを使う
-   パスパラメータを受けとる
    -   `/delete/:id`の場合
    -   `req.params.id`
-   セッション
    ```js
    // 準備
    const session = require("express-session");
    app.use(
        session({
            secret: "my_secret_key",
            resave: false,
            saveUninitialized: false,
        })
    );
    // 下記に保存することで以降のリクエストでセッションが送られる
    req.session.userId = "xxxx";
    req.session.userName = "xxxx";
    // セッション削除（ログアウト）
    req.session.destroy((error) => {
        実行後の処理;
    });
    ```
-   ejs への値の渡し方
    -   app.js
        -   `res.locals.username = 'xxx'`
    -   xxx.ejs
        -   `<%= locals.username %>` // 注意 res がつかない
- 一つのルートの中に複数のミドルウェアを記載できる
    - ミドルウェアは上から順次実行される
    - next()で次のミドルウウェアへ
        ```js
        app.post('/login',
            (req, res) => { /**/ next(); },
            (req, res, next) => { /**/ next(); }, // nextの引数が必要
            (req, res, next) => { /**/ next(); }, // nextの引数が必要
            ...
            )
        ```
- パスワードのハッシュ化はbcriptを使う
  
## ejs

-   Embedded JavaScript
-   見た目を表現するもの
-   HTML と JS のコードの両方が記載可能
-   使用
    -   `npm install ejs`
    -   `<%=%>`でくくる
-   送信
    -   `<form action="/create" method="post`
-   他の ejs ファイルの読み込み
    -   = でないので注意
    -   <%- include("header"); %>
