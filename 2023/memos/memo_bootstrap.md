# Bootstrap

## 概要

- フロントエンド開発のためのフレームワーク
- レスポンシブ対応が容易
- CSSフレームワークとも言われる
- メリット：早い
- デメリット：似たようなデザインになりがち
- リンク
  - 公式：https://getbootstrap.com/
  - cheat sheet:https://bootstrap-cheatsheet.themeselection.com/
  - button: https://getbootstrap.com/docs/5.0/components/buttons/

### 準備

```html
<head>
  <!-- linkの追加 -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
    crossorigin="anonymous"
  />
</head>
<body>
  <!-- scriptをbody末尾に記載 -->
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
    crossorigin="anonymous"
  ></script>
</body>
```

### 使い方

- URLから使いたい要素を探す
- サンプルコードをコピペする
  - 補足：どんなクラスが指定されているかを意識・確認する
- activeで選択中、disableで無効化
- スタイルの当て方
  - cssで手書き指定ではなくclassで指定する
    - 属性のclassに追加：class="navbar-light bg-light"
    - 余白：https://getbootstrap.jp/docs/5.3/utilities/spacing/
      - 例: mt-0, ms-1, px-2, p-3
      - margin:m, padding:p,
      - top:p, b:bottom, s:start=left, e:end=right
      - x:left&right, y:top&bottom
      - 0-5
  - または属性のstyle="background-color:red;
- 中央揃えにするには下記で括る
  - `<div class="container"></div>`
  - ウインドウ幅いっぱい：`<div class="container-fluid"></div>`

#### Grid System

```html
<!-- 基本 -->
<!-- col-xの値の合計が12になるようにする -->
<div class="row">
  <div class="col-6">6</div>
  <div class="col-3">3</div>
  <div class="col-2">2</div>
  <div class="col-1">1</div>
</div>
<!-- 指定しないとautoとなる -->
<div class="row">
  <div class="col">auto</div>
  <div class="col-3">3</div>
  <div class="col-2">2</div>
  <div class="col-1">1</div>
  <div class="col">auto</div>
</div>
```

- 幅いっぱい(12)になるブレークポイントを指定する

  - 例:`col-sm-6`, `col-xl-2`
    |種類|class-prefix|画面幅px|
    |--|--|--|
    |ExtraSmall|なし|576未満|
    |Small|sm|576以上|
    |Medium|md|768以上|
    |Large|lg|992以上|
    |ExtraLarge|xl|1200以上|

- ミックスアンドマッチによるレスポンシブデザイン
  - 元：https://getbootstrap.jp/docs/5.3/layout/grid/#ミックスマッチ

```html
<!-- 992pxでcol-lg-1のlgのブレークポイントが発動し、col-md-2の2が有効になる -->
<!-- 768pxでmdが効いて12になる -->
<div class="col-lg-1 col-md-2 orange">1</div>
```

- ネスト

```html
<!-- ネストするグリッドの挿入位置に注意 -->
<div class="row">
  <div class="col-sm-9 orange">
    Level 1:9
    <!-- ここ、divの中に次のカラムを入れる -->
    <div class="row">
      <div class="col-sm-8 orange">Level 2:8</div>
      <div class="col-sm-4 orange">Level 2:4</div>
    </div>
  </div>
  <div class="col-sm-3 orange">Level 1:3</div>
</div>
```

- ジャンボトロンフォーム
