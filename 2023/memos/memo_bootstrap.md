# Bootstrap

## 概要

- フロントエンド開発のためのフレームワーク
- レスポンシブ対応が容易
- CSS フレームワークとも言われる
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

- URL から使いたい要素を探す
- サンプルコードをコピペする
- どんなクラスが指定されているかを確認する
- active で選択中、disable で無効化
- スタイルの当て方
  - 属性の class に追加：navbar-light bg-light
  - 属性の style="background-color:red;

#### Grid System

```html
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

- 縦並びになるブレークポイントを指定する
    - 例:`col-sm-6`, `col-xl-2`
  |種類|class-prefix|画面幅 px|
  |--|--|--|
  |ExtraSmall|なし|576 未満|
  |Small|sm|576 以上|
  |Medium|md|768 以上|
  |Large|lg|992 以上|
  |ExtraLarge|xl|1200 以上|
