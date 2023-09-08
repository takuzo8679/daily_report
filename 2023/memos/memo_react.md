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

## コンポーネント
- class名がコンポーネント名になる
- React.Componentを継承することでコンポーネントになる
- ファイル記載内容
    ```js
    // /react-app-name/src/components/.../MyComponents.js
    import React from 'react';
    import ChildComponentIfNeeds from './ChildComponent'
    class MyComponent extends React.Component {
        render() {
            // ここでJSXを作成して変数に代入可能。その場合は()でくくること。
            const some = !this.state.isSome? null : {/* JSX */}

            return(
                {/* Write your JSX */}

                {/* 子コンポーネント呼び出し */}
                <ChildComponentIfNeeds 
                    propsName1='value1' {/* props渡す */}
                    propsName2='value2'
                />

                {/* map呼び出し */}
                {itemList.map((item) => {
                    return(             {/* returnつける */}
                    <SomeComponent
                        name={item.name} {/* {}でくくる */}
                        image={item.image}
                    /> {/* 閉じ忘れ注意 */}
                    )
                    })
                }


            );
        }
    }
    export default MyComponent;
    ```

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
- 閉じタグの違い
    - |HTML|JSX|
        |--|--|
        |`<img>`|`<img />`|
        |`<input>`|`<input />`|
        |`<textarea></textarea>`|`<textarea />`|
        |`<form></form>`|`同左`|

- imgタグ
    - 変数を使用する場合は`"`は省略できる：`src={imgUrl}`
- css
    - ~~class~~ではなく`className`と書く