# html cssの学習メモ

- 行の高さ指定：`line-height`：heightと一致させると高さに一致
- 太字：font-weight:normal/bold;
- 画像を横幅いっぱいに広げる:width:100%;
- 複数の要素を横幅に並べる：width:100%/n;
- インライン要素の中央寄せ：display: inline-block;
- 時間遷移：transition: all 0.5s;
- 要素を横並びにする方法：display:flex;
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