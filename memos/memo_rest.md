### RESTの概要

##### 概要

- RESTはREpresentational State Transferの略
- 設計ルールやWebのアーキテクチャスタイルのことを示す
- RESTというとAPIを連想するがその前段にこのような設計原則がある
- 2000年にRoyFieldingが発表（一部は古くなっている箇所もある）
  - https://ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm


##### RESTの6つの原則

RESTは下記の6つの原則よって構成されており、昨今のWebシステムはほぼこれにしたがっている。

###### クライアント/サーバー

- UIとデータが分離される
  - クライアント側はマルチプラットフォームに対応できる
  - サーバー側は可用性を高められる
- クライアント側がトリガー、サーバーは受け身（昨今はサーバーからもPUSHするケースもある）

###### 階層化システム

- Web/AP/DBのように階層を持たせる

###### コードオンデマンド

- サーバーからコードをDLしてクライアント側で実行する
  - クライアントを分離してサーバー側で変更が可能
- サーバー側の負荷が下がる

###### 統一インターフェイス

- ざっくり表現するとHTTPで定義されている8つのメソッドのみを用いること
  - インターフェイスに制約を加えることで全体のアーキテクチャがシンプルになる
- 詳細には4つの原則が存在する
  - リソースの識別
    - URIサーバーへのデータへアクセスする
    - 天気のように変化し続けるものであれば特定の日付やlatestなどの断面も含まれる
    - データであって動作は含まれない
  - 表現を用いたリソース操作
    - リクエストを送る際に表現（認証情報などの追加情報）を付与してサーバー側にリソースの編集を依頼すること
    - Authorization: Bearer ... など
  - 自己記述メッセージ
    - メッセージ内容をHeaderに記載する
    - Content-Type: test/plainなど
  - アプリケーション状態エンジンとしてのハイパーメディア（HATEOS）
    - HATEOS: Hypermedia As The Engine Of Application State
      - クライアントが自分の状態や位置が正しくわかるようすること（例。WebサイトのHyperLink）

###### ステートレス

- サーバーは状態を持たずにリクエストのみで完結させる

###### キャッシュ制御

- クライアント側でレスポンスをキャッシュして不要なやりとりを減らす

### REST APIの概要

- RESTの統一インターフェイスに則り、HTTPの8つメソッドを用いてCRUD操作を行うAPI
- リクエストはリソースを示すURIと、リソースを操作するHTTPメソッドで構成される
- URIは複数形で記載する
- movieをリソースとした場合の設計例

| URI          | HTTP method | 効果                          |
| ------------ | ----------- | ----------------------------- |
| /movies      | GET         | movieの一覧取得               |
| /movies      | POST        | 新規movieの追加               |
| /movies/{id} | GET         | 個別movieの情報取得           |
| /movies/{id} | PUT         | 個別movieの情報更新(置き換え) |
| /movies/{id} | PATCH       | 個別movieの情報更新(部分更新) |
| /movies/{id} | DELETE      | 個別movieの削除               |

### 参考

- [Webを支える技術](https://www.amazon.co.jp/dp/4774142042)
- [REST WebAPI サービス 設計](https://www.udemy.com/course/rest-webapi-development/)
