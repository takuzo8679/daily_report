# html cssの学習メモ

## 汎用

- ボックス：HTMLでマークアップされた要素（タグ＋コンテンツ）
  - ボックスモデル：内側からコンテンツ領域、パディング領域、ボーダー領域、マージン領域
- マージンの相殺
  - 上要素がmargin-bottom100px,下要素がmargin-top50pxの場合、実際の要素間マージンは大きい100pxが優先され、小さい50pxは100pxに内包される形になる
  - 親子要素でも同様
  - 左右のマージンは相殺されない
- 擬似クラス
  - 要素の状態に応じてCSSの設定を適用すること
    - a:link未訪問、a:visited, a:hover, a:activeクリック状態のリンク
- フォントはhtmlセレクタにfont-familyプロパティで指定する
  - カンマ区切りで複数指定可能。左優先
  - フォント名はダブルクォーテーションで括るが、フォントファミリは括らない
  - serif:明朝体、sans-serif:ゴシック体
  - Windows、Mac、Linuxで標準で入っているフォントを指定する例
    - `html{font-family: "メイリオ", "Hiragino Kaku Gothic PronN", sans-serif;}`
- h1は1ページに一つだけ
- 行の高さ指定：`line-height`：heightと一致させると高さに一致
- 太字：font-weight:normal/bold;
- 画像を横幅いっぱいに広げる:width:100%;
- 複数の要素を横幅に並べる：width:100%/n;
- インライン要素の中央寄せ：display: inline-block;
- 時間遷移：transition: all 0.5s;
- 要素を横並びにする方法：display:flex;
- エリアを要素の大きさを内容に合わせる：width: fit-content;
- 左右に寄せる
  - float: left/right; // flex boxの場合
  - margin: 0 0 0 auto; // 左だけautoにすることで右端による
- 文字を左に寄せる:`margin-left: auto;`
- 文字の装飾をなくす
  - 親の設定を維持`color: inherit;`
  - 設定を外す`text-decoration: none;`
- 初期設定をクリアする：`margin: 0;`
- 境界線
  - 作る：`border: 1px solid #000;`
  - 角を丸める：`border-radius: 30px;`
- ボックスモデル
  - widthは中身の幅。pなら文字列の端から端になる。
  - paddingはwidthから外側に広がる
  - marginはpaddingから外側に広がる
  - ボックスの大きさ=width+padding+margin
- 文字数の分だけwidthを確保したい場合`width:7em;`
  - 残りのエリアの例:`width: calc(100%-7em);`
- 背景色を指定しない場合は透明になる
- 繰り返し：repeat(3, 22px)は22px 22px 22pxと同じ
- section tag:h1が含まれるくらい大きい見出しで使われる
- クラスの共通設定を記載する：`.text1, .text2 {}`
- 構造化タグ：レイアウトを変える目的のみでhtmlに追加するタグのこと
- span
  - 特に意味がないタグになる
  - 実務上は装飾時に活用される
  - 自身は幅と高さを持たないので指定したい場合は`display:inline-block;`を追加する
- formの属性
  - action:送り先(ex. /index/post)
  - method:post/get
  - encotype:暗号化方式(ex.text/plain)
  - id:uniqueな名前
- img
  - アスペクト比を維持したまま画像幅に合わせる`object-fit: cover;`
- input

  - 属性
    - type:入力データの形式(ex.text/radio/check box/pull down)
      - type="reset"でリセットする
    - name:処理時に使用する名前(name=xxxで取り出す)
    - size:入力される文字数(半角)
    - maxlength:入力文字数の最大値(devツールで書き換え可能)
    - required:入力必須にする(devツールで書き換え可能)
    - placeholder:入力前の説明
    - form:上のformのidと同じものを入れて紐付ける
      - formタグの外側に置いた場合に使用
    - radioサンプル（nameを同じ名前にする）
      ```html
      <input type="radio" name="gender" value="male" />male
      <input type="radio" name="gender" value="female" />female
      <input type="radio" name="gender" value="unselected" checked />無回答
      ```
  - label

    - input要素と関連付ける
      - textと関連づけると入力欄にフォーカスされる
      - ラジオボタンに関連づけると選択される
    - ```html
      <!-- forで関連づける -->
      <label for="username">お名前</label>
      <input type="text" id="username" />
      <!-- またはlabelで囲う -->
      <label><input type="radio" name="gender" value="male" />male</label>
      ```

- aタグは包む順番は関係ない(pの内側でも外側でもOK)
- aタグで新タブで開く`target="_blank" rel="noopener"`
- ページ内リンク
  - ```html
    <a href="#hoge"
      >foo<a>
        <h2 id="hoge">
          bar
          <h2></h2></h2></a
    ></a>
    ```
- aタグで画像を指定した時のずれ
  - imgタグinline要素（横幅を持たない）ため
  - aタグで包んだimgタグをblock要素にして幅を指定すれば良い
  - ```css
    .SNS_Logo a {
      display: block;
      width: 20%;
    }
    .SNS_Logo a img {
      width: 100%;
    }
    ```
- 文字に下線をつける
  - text-decoration: underline; text-underline-offset:0.5em;
  - border-bottom:;width:content-fit;
  - `<u></u>`
- imgを丸くする：border-radius:50%;
- smallタグ：著作権など小さい表記に使用する（デザイン目的では使用しない）
- 文字実体参照
  - 著作権のcマークなど
    - `&copy;`と記載すると&copy;と表記される
- css
  - 現在のversionは3。下位互換性あり
  - 色がゾロ目の場合は簡略できる：#aabbcc=#abc
  - htmlでも装飾できるがあまりやるべきでは無い
    ```html
    <style>
      h2 {
        color: #00ff00;
      }
    </style>
    <body>
      <h1 style="color: #ff0000">inline</h1>
      <h2>内部参照</h2>
    </body>
    ```
- アイコンの使い方
  ```html
  <!-- 準備 -->
  <!-- 読み込み -->
  <link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
  />
  <!-- サイトから使用したいものを探す -->
  　<!-- https://icons.getbootstrap.jp/ -->
  <!-- 使用 -->
  <i class="bi bi-heart"></i>
  ```

## 具体例

- ボタンの作り方
  - `<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">`
  - ```html
    <a class="btn facebook" href="#">
      <span class="fa fa-facebook"> Facebookで登録 </span>
    </a>
    ```
  - display:inline-block;
  - 角を丸めるborder-radius:30px;
  - background-color:#3b5998;
- ボタンの影
  - box-shadow: (none|0px 7px #1a7940);
  - position:relative;
  - top:7px;
- 文字の間隔：letter-spacing:5px;
- 透過＠カーソル当てた時
- ```css
  .btn:hover {
    opacity: 1;
  }
  ```
- 背景イメージ
- ```css
  background-image: url(https://xxx);
  background-size: cover;
  ```
- 背景固定
  - position: fixed;
  - top:0;
  - z-index:10;
- ## 要素を重ねる
  ```css
  .parent {
    position: relative; /*親の座標を起点にする*/
  }
  .child {
    position: absolute;
    top: 90px;
    width: 100%; /*幅いっぱい*/
  }
  ```
- 子要素が全てfloatでも親要素が高さを持つようにする
  - 空クラスを追加:`<div class="clear"></div>`
    - 最後の要素の次に追加すること！
  - css
    ```css
    .clear {
      clear: left;
    }
    ```
- 親のmarginやpaddingを無視して画像をウインドウ幅いっぱいに表示する(参考：haniwaman.com/inner-over/)
  ```css
  /* 見えているウィンドウ幅に広げる=Viewport Width */
  width: 100vw;
  /* このままだと画像の始点が親の位置のままなのでウインドウ端に移動する */
  /*  1.  50%でウィンドウの中央に移動する */
  /*  2. -50vwで画像幅の半分だけ画面端に移動する */
  margin: 0 calc(50% - 50vw);
  ```
- cssのネスト化

  - 共通のクラスだけcommon-textとする方がシンプルに記載できる
    - class名は"self-produce-contents-text"のように長くする必要はない

  ```html
  <section class="section1">
    <p class="common-text"></p>
  </section>

  <section class="sectioin2">
    <p class="common-text"></p>
  </section>
  ```

  ```css
  .common-text {
    <!-- 両方に適応したいstyle -->
  }

  .section1 {
    .common-text {
      <!-- section1の方のみに、適応したいstyle -->
    }
  }
  ```

- テーブル（表）の作り方

  - thead, tbody, tfootを使用した方がcssを当てやすいが必須ではない
  - 属性：colspan、rowspanで結合

    ```html
    <table border="1">
      <caption>
        caption
      </caption>
      <thead>
        <!-- table row -->
        <tr>
          <!-- table headerー -->
          <th>header 1</th>
          <th>header 2</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <!-- table data -->
          <td>body1</td>
          <td>body2</td>
        </tr>
      </tbody>
      <tfoot>
        <tr>
          <td>footer1</td>
          <td>footer2</td>
        </tr>
      </tfoot>
    </table>
    ```

    ```css
        <!-- 行間設定 -->
        border-collapse: separate;
        border-spacing: 20px 5px;
    ```

- 選択リスト・ドロップダウンはselectタグ

  - optionで項目を増やし、selectedで初期選択

  ```html
  <select name="area" id="">
    <option value="" selected></option>
    <option value="hokkaido">hokkaido</option>
    <option value="okinawa">okinawa</option>
  </select>
  ```

- 図形内の文字の位置を中心にする
  - ```css
    /* 中央揃えにする */
    display: flex;
    justify-content: center;
    align-items: center;
    ```

## Gridレイアウト

- エクセルのセルのように画面を構成する手法
- まず画面全体を大きなレイアウトを決める
- containerクラスの中にdiv要素を配置してく
- 必要に応じてGrid LayoutやFlex Boxを入れ子にする
- grid-template-rowsの高さ＝一つ上の要素との感覚＋ height
- 1列で行を追加するだけの場合はdisplay:gird;の指定だけでOK(grid-template-xxxは不要)

### css

Sample

|       |       |
| ----- | ----- |
| itemA | itemB |
| itemA | itemC |
|       |       |

```css
.container {
  /* グリッドレイアウトの指定 */
  display: grid;
  width: 800;
  /* 縦の2番目の線を引く。一つ目は180px。1frは残りのスペース(800-180=620) */
  grid-template-columns: 180px 1fr;
  /* minmaxで最小最大を指定できる */
  grid-template-columns: 180px (100px, 1fr);
  /* 比率だけで指定も可能2:3:1 */
  grid-template-columns: 2fr 3fr 1fr;

  /* columnsとrowsを指定しなくてもウィンドウ幅で自動折り返しが可能 */
  /* メディアクエリの使用も不要になる */
  /* fillは余白あり：空きを空白のgridを生成してうめるイメージ */
  grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  /* fitは余白なし：空きを1frで埋める */
  grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));

  /* 横の2番目の線を引く。一つ目は120px。2つ目は90px */
  grid-template-rows: 120px 90px;
  /* 子要素の高さにする場合はautoと書ける */
  grid-template-rows: auto auto;

  /* 間隔の指定 行間　列幅 */
  gap: 30px 20px;
}
.itemA {
  /* 縦線の指定：1と2 */
  grid-column: 1/2;
  /* 横線の指定：1と3 */
  grid-row: 1/3;
}
.itemB {
  /* 番号が続く場合は/を省略できる */
  grid-column: 2; /* 2/3と同じ */
  grid-row: 1;
}
.itemC {
  /* Grid layoutではセルサイズが1の場合は
    左上から右、下の順に自動で判別して埋めてくれる */
  /* grid-column: 2; 省略可能*/
  /* grid-row: 2; 省略可能*/
}
```

## html5の新規グループ化タブ

- `<div class="header"></div>`と従来書いていた
- `<header></header>`と書けるようになった
- 他にもfooter, main, figure, articleなど多数ある
- タグを書いた上でclassの宣言も可能
- htmlが認識できるタグで書いた方が処理上有利になるとのこと
- div: 意味なし
- section: セクション
  - 見出し＋コンテンツの塊
- header: セクションのヘッダー
- footer: セクションのフッター
- main: 文章のメインコンテンツ領域
- article: 記事コンテンツ要素
  - sectionとの違い:この要素だけで完結するものを示す
- aside: 余談要素
  - 用語の説明や広告要素
- nav: ナビゲーション

### Flex box

- itemを左右に並べるのに有利
- Grid layoutの前によく使われた手法
- 親要素であるコンテナに子要素であるアイテムを入れる
-

```css
.header {
  /* Flex boxの指定 */
  display: flex;
  /* コンテンツを左右均等に配置 */
  justify-content: space-between;
  /* 配置の向き : row(デフォルト) 左->右  column: 上->下*/
  flex-direction: column;
  /* 画面端で折り返す */
  flex-wrap: wrap;
  /* directionとwrapを一行で指定する */
  flex-flow: row wrap;
  /* 配置centerで中央寄せ、space-betweenで均等配置*/
  justify-content: space-between;
  /* 高さ方向の配置を指定する */
  align-items: center;
  /* 親要素の高さ方向に空きスペースがある場合の配置を指定する */
  align-content: center;
}
.header ul {
  /* Flex boxの指定 */
  display: flex;
  /* liの・の点の削除 */
  list-style-type: none;
  /* liを離す */
  /* まず幅指定 */
  width: 180px;
  /* 次に左右均等配置 */
  justify-content: space-between;
}
```

## リンク

- href="#" とするとクリックしても何も起きない。ヌルリンクと呼ばれる。

## レスポンシブWebデザイン

- css3から導入された
- 右記の三つから構成されるMedia Queries, Fluid Grid, Fluid Image
  - メディアクエリ、フルードグリッド、フルードイメージ

### Media Queries

- 設計方針：最初にスマホなどの小さい画面から実装してタブレット、PCの順に大きくしていく
  - htmlは共通
  - cssはスマホの下にタブレットなどを追記していく → デバイスによって上書きで読み込まれる
  - Media Queryが画面サイズを検出してくれる
    - `@media screen and (min-width: 600px) {}`
- 横幅であるwidthや余白をpxで直接指定せずに%で記述する
  - %は親要素のwidthで決まる
  - 画像のwidthが決まればheightが自動で決まるのでautoで良い
    - grid-template-rows
      - 縦に積み上げるだけなら全てautoで不要になる
  - 全ての項目を相対値で決める必要はない
    - 場合によっては割り切る
- コンテンツの内容が少ない場合はmax-widthを設けて余白を増やす

#### html

- レスポンスwebデザイン使用時のメタタグ
  - `<meta name="viewport" content="width=device-width">`
  - 大きな表示をデバイスに合わせるおまじない

### Fluid Grid / Image

- 画面サイズに応じてフォント、画像などの要素を変化させる技術
- 相対値の%やemで指定する
  - 1emが基準値の1倍
  - font-sizeのデフォルトは16pxなので、その時の1.5emは24pxになる
  - line-heightは文字数を基準にするのでよく使われる
  - `width: 100%;`として横を画面いっぱいにするのがよく使われる
- 最初から相対値指定は難しい。最初は絶対値で画面ができてから相対値に直すのが良い。
- 背景画像として設定する場合

```css
figure {
  background-image: url(images/mejiro.jpg);
  /* 親の高さを継承 */
  width: 100%;
  /* 高さは0として */
  height: 0;
  /* 比率を入れる */
  padding-bottom: 66.72%;
  /* 下記を入れると全体表示 */
  background-size: cover;
  margin-bottom: 30px;
}
```

### emmet省略記法

- div.item{item0}\*6 +Tab →`<div class="item">item0</div>`が6こ
