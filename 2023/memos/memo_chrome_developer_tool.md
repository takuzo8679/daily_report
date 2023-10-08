# Chrome developer tool

## Elements
### 概要
- Style
    - element.styleで要素を直書きできる
- Layout
    - Grid layoutのcolumやrowの番号を表示できる
    - Flexの情報も表示できる
- Event Listeners
    - clickなどのイベントを一覧できる
    - removeのできる
    - FrameWorkのものも見える
- DOM Breakpoints
    - DOMに変化が起きた時にブレークポイントを貼れる
- Properties
    - JSからアクセスできるpropertiesを一覧表示できる
- Accessibility
    - 要素の位置を表示するDOMツリーのサブセット
    - あまり使われない？
### 詳細
- スマホの表示も可能
- マウスポインタで当てることも可能
- cssが取り消し線になっていたら適用されていない
    - 例えばインラインで実装されている
    - 


## Console
### console.logでの表示が見える
- 右クリックで色々できる
    - copy property pathなど
- エラー表示ができる
### JavaScriptが打てる
- コンソール上で実行できる（スコープは？）

## Sources
- ソースを読み込める
- 何か表示されない場合はここでリンク切れを確認すると良い
- ウォッチが使える
- ブレークポイントが使える
    - XHRブレーク、DOMブレーク、Event Listenerブレーク
    - クリックにもブレークポイントを貼れる

## Application
- ブラウザのStorageやCacheなどの各機能を表示
- Cookies
    - 20件、有効期限あり
- Session Storage
    - 開いている間は保存してくれるがタブを閉じたら消える
- Local Storage
    - タブを閉じても保存できる
    - オリジン単位で保存される（host+port)
    - 10MB程度保存可能
- IndexedDB
    - ほぼDB
    - key-value型
    - 数十MB存在
- Web SQL
    - 標準から外れてほぼ使われず
    - SQLiteに近い
- Manifest
    - PWAのために必要な記載
    - PWA（プログレッシブウェブアプリ）はWebサイトをネイティブアプリのように扱える技術のこと
- Service Workers
    - statusが赤の場合はエラー、緑はOK
    - バックグラウンド処理
- Storage
    - Storage情報を表示
- Cache Storage
    - 画像などがcacheされる
- Background Service
    - 最近追加された
- Frames
    - ソースコード一覧

## Lighthouse
- PageSpeed Insightsとほぼ同値
- 良いページを作るための指標
- Googleの採点づけ方針
    - https://developers.google.com/search/blog/2020/05/evaluating-page-experience?hl=ja
- サイトのパフォーマンスを測定できる
- 指標
    - First Contentful Paint(FCP)
        - 最初のコンテンツが表示されるまで
    - Largest Contentful Paint (LCP)
        - サイトで一番重要なコンテンツを表示するまでの時間
        - Googleが自動で判断
    - Speed Index Score
        - ページが早く表示されるか
    - Time to Interactive
        - ユーザーが操作できるまでの時間
    - Total Blocking Time(TBT)
        - FCPからTTIまでの時間
    - Cumulative Layout Shift
        - ページ読み込み時にレイアウトのずれ
            - クリックしようとしたらズレる
- ページの実装中よりも完了してからスコア改良を行う方が早い

## Network
- Devツールを立ち上げた状態でリロードが必要
- 読み込んだファイル一覧が表示される
- 上から目線でよも込まれた順
- HeaderでAPI情報が見られる
    - uri,status code
- Previewでjsonのオブジェクト情報などが見られる
- Timingで時間表示
    - TTFB(Waiting for server response) Responseの時間
- XHR：非同期/Ajax。ページ全体を更新せずに一部データを受け取り表示できる

## Security
- サイトを開いたら一度見ると良い
- GreenであればOK
- NGの例
    - httpの場合（非同期でリクエストするものも含まれる）

## More Tools
- 三点目メニュー > More Tools > 
- Animation: cssアニメーション
    - 起動してからリロード
    - 一度CSSで組んでから値調整はエディタではなくこちらで行うと良い
- sensor: GPSなど。値を自由に設定可能
- search: 全HTMLファイルから検索可能
- CSS Overview: 概要表示

## Recorder
- ブラウザの操作を記録してくれる
- テストに便利
- json形式で保存可能（スクリーンショットと説明文が不要になる）
- 上記をインポートすると再生可能

## 最新情報とドキュメント
- 公式情報 
    - https://developer.chrome.com/
- 最新情報はブログに載っている
- 使い方はDocs
    - 例えばCSS
        - https://developer.chrome.com/docs/devtools/css/