# Document Object Model

## 概要

HTMLページを操作するもの

### DOMツリー

HTMLドキュメントをツリー構造として表現したもの

- Document
  - `<html>`
    - `head`
      - `title`
    - `body`
      - `h1`
      - `h2`
      - `p`
        - `strong`

### ノード

文書を構成する要素、属性、テキストといったオブジェクトをノードと呼ぶ。
DOMツリーの一つ一つがノード

- 要素ノード
- 属性ノード
- テキストノード

### ブラウザオブジェクトの階層構造

- window: ブラウザ操作の機能を集めたオブジェクト
  - screen:　ディスプレイに関する情報を提供
  - document: HTMLコンテンツを保持しているオブジェクト。操作するのはDOM
    - forms: formに関する情報、操作を提供。
      - elements:タグのこと
    - anchors:aタグに関する情報を扱う
    - images:画像の情報提供と操作
  - location:　表示されているページのURLを提供できる
  - navigator:　ブラウザ名、バージョンなど、ブラウザ固有の情報を提供する
  - history:　ブラウザ履歴の操作。ページ移動などの操作をしてくれる。

## DOMの操作

### 取得

- document.getElementById(id)
  - idがなければnullが変える
  - innerTextメソッドを使用すると(例えばpタグ内の)テキストのみが取得できる
- document.getElementsByTagName(tagName)
  - 戻り値はHTMLCollection(配列)
  - 存在しない場合はからnullではなく空配列
- document.getElementsByName(name)
- document.getElementsByClassName(name)
  - 同上
- input textの文字列取得
  `const text = document.getElementById("textBox").value;`

### 作成

#### 追加

- document.createElement(elementName)
  - ノードを作成するだけなので別途追加するメソッドが必要
- document.createTextNode(text)
  - 同上
- 指定された要素を最後の子要素として追加
  - element.append(node)
  - 戻り値：追加した子ノード

```js
// textBoxの要素を取得し、そこから文字列取得
const text = document.getElementById("textBox").value;
// textノード追加
const textNode = document.createTextNode(text);
// 要素作成
const listElement = document.createElement("li");
// ノード追加
listElement.appendChild(textNode);
// 親要素取得
const list = document.getElementById("list");
// 親要素に子要素追加
list.appendChild(listElement);
```

#### 置換

- nodeの置き換え
  - appendChildとremoveChileを同時に行う

```js
// 新規要素作成
const newList = document.createElement("li");
// 属性追加
newList.setAttribute("id", "newList");
// node作成
const text = document.createTextNode("new element");
// node追加
newList.appendChild(text);
// 置換前の要素を取得
const oldList = document.getElementById("oldList");
// 親要素を取得
const parentNode = oldList.parentNode;
// 置換実行。new, oldの順であることに注意
parentNode.replaceChild(newList, oldList);
```

- node削除
  - oldChild = element.removeChild(child)

```js
// 親要素取得
const parentElement = document.getElementById("list");
// 子要素取得
const elements = parentElement.getElementsByTagName("li");
// リストの最後を削除
parentElement.removeChild(elements[elements.length - 1]);
```

### イベント

- イベント：ブラウザ上のユーザーの処理
  - マウスをクリック、ポインタの移動、など
- イベントハンドラ：イベントの発生をきっかけとした処理

#### 関連づけ

- onclickによる関連づけ

```js
const e = document.getElementById("button");
e.onclick = () => {
  console.log("clicked!");
};
```

- 要素オブジェクト.addEventListener(イベントの種類, () =>{}, false) - falseはイベントの伝搬形式で使用可能

  ```js
  const e = document.getElementById("button");
  e.addEventListener(
    "click",
    () => {
      console.log("clicked!");
    },
    false
  );
  ```

- loadイベントによる関連づけ
  - loadとは
    - 関連付けられた要素が読み終わった時に発生するイベント
    - 画像を含む全要素が読み終わった後などに実行する

```js
window.onload = () => {
  console.log("loaded!");
};
```
