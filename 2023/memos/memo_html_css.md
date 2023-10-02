# html css の学習メモ

-   行の高さ指定：`line-height`：height と一致させると高さに一致
-   太字：font-weight:normal/bold;
-   画像を横幅いっぱいに広げる:width:100%;
-   複数の要素を横幅に並べる：width:100%/n;
-   インライン要素の中央寄せ：display: inline-block;
-   時間遷移：transition: all 0.5s;
-   左右に寄せる：float: left/right;
-   文字を左に寄せる:`margin-left: auto;`
-   文字の装飾をなくす
    -   親の設定を維持`color: inherit;`
    -   設定を外す`text-decoration: none;`
-   初期設定をクリアする：`margin: 0;`
-   境界線
    -   作る：`border: 1px solid #000;`
    -   角を丸める：`border-radius: 30px;`
-   要素を横並びにする方法：display:flex;
-   ボックスモデル
    -   width は中身の幅。p なら文字列の端から端になる。
    -   padding は width から外側に広がる
    -   margin は padding から外側に広がる
    -   ボックスの大きさ=width+padding+margin
-   背景色を指定しない場合は透明になる
-   繰り返し：repeat(3, 22px)は 22px 22px 22pxと同じ
-   section tag:h1が含まれるくらい大きい見出しで使われる
-   クラスの共通設定を記載する：`.text1, .text2 {}`
-   ボタンの作り方
    -   `<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">`
    -   ```html
        <a class="btn facebook" href="#">
            <span class="fa fa-facebook"> Facebookで登録 </span>
        </a>
        ```
    -   display:inline-block;
    -   角を丸める border-radius:30px;
    -   background-color:#3b5998;
-   ボタンの影
    -   box-shadow: (none|0px 7px #1a7940);
    -   position:relative;
    -   top:7px;

-   文字の間隔：letter-spacing:5px;
-   透過＠カーソル当てた時
-   ```css
    .btn:hover {
        opacity: 1;
    }
    ```
-   背景イメージ
-   ```css
    background-image: url(https://xxx);
    background-size: cover;
    ```
-   背景固定
    -   position: fixed;
    -   top:0;
    -   z-index:10;
-   要素を重ねる
    -
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
-   子要素が全て float でも親要素が高さを持つようにする
    -   空クラスを追加:`<div class="clear"></div>`
        -   最後の要素の次に追加すること！
    -   css
        ```css
        .clear {
            clear: left;
        }
        ```

## Grid レイアウト

-   エクセルのセルのように画面を構成する手法
-   まず画面全体を大きなレイアウトを決める
-   container クラスの中に div 要素を配置してく
-   必要に応じて Grid Layout や Flex Box を入れ子にする
-   grid-template-rows の高さ＝一つ上の要素との感覚＋ height
-   1 列で行を追加するだけの場合は display:gird;の指定だけで OK(grid-template-xxx は不要)

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
    /* 比率だけで指定も可能　2:3:1 */
    grid-template-columns: 2fr 3fr 1fr;

    /* 横の2番目の線を引く。一つ目は120px。2つ目は90px */
    grid-template-rows: 120px 90px;
    /* 子要素の高さにする場合はautoと書ける */
    grid-template-rows: auto auto;

    /* 間隔の指定 縦　横 */
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

## html5 の新規 tag

-   `<div class="header"></div>`と従来書いていた
-   `<header></header>`と書けるようになった
-   他にも footer, main, figure, article など多数ある
-   タグを書いた上で class の宣言も可能
-   html が認識できるタグで書いた方が処理上有利になるとのこと

### Flex box

-   item を左右に並べるのに有利
-   Grid layout の前によく使われた手法

```css
.header {
    /* Flex boxの指定 */
    display: flex;
    /* コンテンツを左右均等に配置 */
    justify-content: space-between;
}
.header ul{
    /* Flex boxの指定 */
    display: flex;
    /* liの・の削除 */
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
    - cssはスマホの下にタブレットなどを追記していく→デバイスによって上書きで読み込まれる
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
figure{
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

### Fluid Image