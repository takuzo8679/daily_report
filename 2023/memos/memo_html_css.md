# html cssの学習メモ

- 行の高さ指定：`line-height`：heightと一致させると高さに一致
- 太字：font-weight:normal/bold;
- 画像を横幅いっぱいに広げる:width:100%;
- 複数の要素を横幅に並べる：width:100%/n;
- インライン要素の中央寄せ：display: inline-block;
- 時間遷移：transition: all 0.5s;
- 左右に寄せる：float: left/right;
- 要素を横並びにする方法：display:flex;
- ボックスモデル
    - width は中身の幅。p なら文字列の端から端になる。
    - padding は width から外側に広がる
    - margin は padding から外側に広がる
    - ボックスの大きさ=width+padding+margin
- ボタンの作り方
    - `<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">`
    -
        ```html
        <a class="btn facebook" href="#">
        <span class="fa fa-facebook">
            Facebookで登録
        </span>
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
- 
    ```css
    .btn:hover{
      opacity:1;
    }
    ```
- 背景イメージ
- 
    ```css
    background-image: url(https://xxx);
    background-size:cover;
    ```
- 背景固定
    - position: fixed;
    - top:0;
    - z-index:10;
- 要素を重ねる
    -  
    ```css
    .parent{
        position:relative; /*親の座標を起点にする*/
    }
    .child{
        position:absolute;
        top:90px;
        width:100%; /*幅いっぱい*/
    }
    ```
- 子要素が全てfloatでも親要素が高さを持つようにする
    - 空クラスを追加:`<div class="clear"></div>`
        - 最後の要素の次に追加すること！
    - css
        ```css
        .clear{
            clear:left;
        }
        ```
## Gridレイアウト
- エクセルのセルのように画面を構成する手法
- containerクラスの中にdiv要素を配置してく
### css
Sample

|||
|--|--|
|itemA|itemB|
|itemA|itemC|
|||

```css
.container{
    /* グリッドレイアウトの指定 */
    display: grid;
    width: 800;
    /* 縦の2番目の線を引く。一つ目は180px。1frは残りのスペース(800-180=620) */
    grid-template-columns: 180px 1fr;
    /* 比率だけで指定も可能　2:3:1 */
    grid-template-columns: 2fr 3fr 1fr;

    /* 横の2番目の線を引く。一つ目は120px。2つ目は90px */
    grid-template-rows: 120px 90px;

    /* 間隔の指定 縦　横 */
    gap: 30px 20px;
}
.itemA{
    /* 縦線の指定：1と2 */
    grid-column: 1/2;
    /* 横線の指定：1と3 */
    grid-row: 1/3;
}
.itemB{
    /* 番号が続く場合は/を省略できる */
    grid-column: 2;/* 2/3と同じ */
    grid-row: 1;
}
.itemC{
    /* Grid layoutではセルサイズが1の場合は
    左上から右、下の順に自動で判別して埋めてくれる */
    /* grid-column: 2; 省略可能*/
    /* grid-row: 2; 省略可能*/
}

``` 