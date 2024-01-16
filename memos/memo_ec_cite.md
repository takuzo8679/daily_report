# EC-siteの作成手順

- 開発環境の構築
  - Ruby On Rails 7
  - Ruby 3.2.1
  - PostgreSQL

##### Herokuへデプロイ

- heroku login

##### bootstrap導入

- 参考：https://github.com/twbs/bootstrap-rubygem/blob/main/README.md
- gemが必要なので追加する。
- 追加後に`bundle install`して再起動するとパイプラインを通じて有効になる。

```ruby
# Gemfile
gem 'bootstrap', '5.2.3' # versionは使用するテンプレートに合わせる。
gem 'jquery-rails' # bootstrapはjQueryを使用する
gem "sassc-rails" # コメントアウトはずす
```

- bootstrapのstyleをimportする。
- `app/assets/stylesheets/application.css`があるので拡張子をscssに変更する。

```scss
// app/assets/stylesheets/application.scss
// 中身をこれだけにする
@import "bootstrap";
```

- importmapとはJavaScriptのモジュールを直接インストールすること。
- Rails 7以降は同梱されている。
- pinでincludeできる。

```ruby
#  config/importmap.rb の任意の位置に追加
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
```

- includeしたjsを実行時にprecompileするように指定

```ruby
# config/initializers/assets.rb 任意の位置に追加
Rails.application.config.assets.precompile += %w[bootstrap.min.js popper.js]
```

- jsの実行コードに依存モジュールを追記する
- 補足：JSが読み込まれる仕組み
  - Rails7ではpropshaftというAssets pipelineがassets読み込みstimulusというgemが起動することでjsが動く
  - 読み込むファイルのデフォルトの場所
    - app/javascript/application.js
  - rails6以前ではsprocketsというgemであった

```js
// app/javascript/application.js の最上部に記載する
//= require jquery3
//= require popper
// 下記はどちらか一方を入れる
//= require bootstrap-sprockets // デバッグを容易にするならこちら
//= require bootstrap // シンプルならこちら
```

- 以上でerbにbootstapの記述(templateのコピペ)ができる様になる

##### modelの作成

- bundle exec rails g Item
  - migrationファイルを編集する
- 主キーのid自動で付与される(auto_increment)

##### Active Storageの設定

ファイル設定

```yml
# config/storage.yml
amazon:
  service: S3
  access_key_id: <%= ENV[AWS_ACCESS_KEY] %>
  secret_access_key: <%= ENV[AWS_SECRET_KEY] %>
  region: <%= ENV[AWS_REGION] %>
  bucket: <%= ENV[AWS_BUCKET] %>
```

```ruby
# config/environments/production.rb
config.active_storage.service = :amazon # devも必要に応じて
```

必要に応じてdotenvを追加しておく

```ruby
# gemfile
gem 'dotenv-rails'
```

```sh
# .env
AWS_ACCESS_KEY=''
AWS_SECRET_KEY=''
AWS_REGION=''
AWS_BUCKET=''
```


```sh
# ActiveStorage用テーブルを作成
bundle exec rails active_storage:install
bundle exec rails db:migrate
```
```ruby
# item.rb
has_one_attached :index_image
```