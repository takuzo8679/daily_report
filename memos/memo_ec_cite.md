# EC-siteの作成手順

- 開発環境の構築
  - Ruby On Rails 7
  - Ruby 3.2.1
  - PostgreSQL
- Herokuへデプロイ

###### bootstrap導入

参考：https://github.com/twbs/bootstrap-rubygem/blob/main/README.md

gemが必要なので追加する。
追加後に`bundle install`して再起動するとパイプラインを通じて有効になる。

```ruby
# Gemfile
gem 'bootstrap', '5.2.3' # versionは使用するテンプレートに合わせる。
gem 'jquery-rails' # bootstrapはjQueryを使用する
gem "sassc-rails" # コメントアウトはずす
```

bootstrapのstyleをimportする。
`app/assets/stylesheets/application.css`があるので拡張子をscssに変更する。

```scss
// app/assets/stylesheets/application.scss
// 中身をこれだけにする
@import "bootstrap";
```

importmapとはJavaScriptのモジュールを直接インストールすること。
Rails 7以降は同梱されている。
pinでincludeできる。

```ruby
#  config/importmap.rb の任意の位置に追加
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
```

includeしたjsを実行時にprecompileする。

```ruby
# config\initializers\assets.rb 任意の位置に追加
Rails.application.config.assets.precompile += %w[bootstrap.min.js popper.js]
```

- 

```js
// application.js
//= require jquery3
//= require popper
//= require bootstrap
```
