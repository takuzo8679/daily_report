# React

## イベント
- `<button onClick={()=>{処理}}>xxx</button>`

## ファイル構造
-  React/
    -  index.html : 表示
    -  src/
        -  index.js : App.jsなどのコンポーネントをhtmlに変換
        -  components/
            -  App.js : jsxを記載

## state
- 使い方
    - 1.constructorの中でオブジェクトとして定義する
        ```js
        constructor(props){
            super(props);
            this.state = {name: 'ken};
        }
        ```
    - 2.jsx内で記載する
        - `こんにちは、{this.state.name}さん`
    - 3.stateの値を変更する
        - `{this.setState({key: value})}`
        - 必ず`setState`を使い、直接変えてはいけない
            - NG:`{this.state = {key: value}}`
            - NG:`{this.state.key = value}`

## JSX
- JSXが記載されるのはrenderのreturn内のみ
- JSで宣言した変数をJSX内で`{}`でくくると使用できる
- コメント:{/* */}
- return内は一つの要素のみ返せる
    ```jsx
    {/* NG複数の要素を記述できない */}
    return(
        <h1>...</h1>
        <h2>...</h2>
        <p>...</p> 
    )
    {/* OK divタグでくくる */}
    return(
        <div>
            <h1>...</h1>
            <h2>...</h2>
            <p>...</p> 
        </div>
    )
    ```
- imgタグ
    - 変数を使用する場合は`"`は省略できる：`src={imgUrl}`
    - 閉じタグ
        - htmlでは不要 `>`
        - JSXでは必要 `/>`
- css
    - ~~class~~ではなく`className`と書く