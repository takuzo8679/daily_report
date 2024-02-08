# EC-siteの作成手順

- 開発環境の構築
  - Ruby On Rails 7
  - Ruby 3.2.1
  - PostgreSQL

##### Herokuへデプロイ

```sh
# デプロイ
heroku login
heroku apps:create
heroku addons:create heroku-postgresql:mini
# 環境変数設定
source .env
heroku config:set AWS_ACCESS_KEY="$AWS_ACCESS_KEY"
heroku config:set AWS_SECRET_KEY="$AWS_SECRET_KEY"
heroku config:set AWS_REGION="$AWS_REGION"
heroku config:set AWS_BUCKET="$AWS_BUCKET"
heroku config:set BASIC_AUTH_USER="$BASIC_AUTH_USER"
heroku config:set BASIC_AUTH_PASSWORD="$BASIC_AUTH_PASSWORD"
# target_branchをherokuへpushする
## 現在のブランチ名
CURRENT_BRANCH=$(git branch --contains | cut -d " " -f 2):main
git push heroku $CURRENT_BRANCH
# setup
heroku run rake db:migrate
heroku run rails db:seed
heroku ps:scale web=1
heroku open
heroku logs --tail

# 削除
heroku addons:destroy heroku-postgresql
heroku apps:destroy
heroku addons --all
heroku apps --all
```

it push heroku feat/item_index

##### bootstrap導入

- cssbundling-railsのgemを使用
  - `rails-new --css-bootstrap`と実行するとcssbundling-railを利用してapp/assets配下にbootstrap利用のためのimportが記述されたものが追加される
  - bootstrap自体はnode_modulesに格納される
  - 詳細手順は右記：https://qiita.com/kazutosato/items/1ae1cf0ec380a75d4dc4

以降は補足bootstrapのgemを使用した場合
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
  access_key_id: <%= ENV['AWS_ACCESS_KEY'] %>
  secret_access_key: <%= ENV['AWS_SECRET_KEY'] %>
  region: <%= ENV['AWS_REGION'] %>
  bucket: <%= ENV['AWS_BUCKET'] %>
```

```ruby
# config/environments/production.rb
config.active_storage.service = :amazon # devも必要に応じて
```

s3へuploadするためにgemが必要

```ruby
# gemfile
gem 'aws-sdk-s3', require: false
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

ActiveStorage使用のためのコマンド実行

```sh
# ActiveStorage用テーブル作成のmigrateファイルの作成
bundle exec rails active_storage:install
# migrate実行
bundle exec rails db:migrate
```

関連付けはモデルで行う

```ruby
# app/models/item.rb
has_one_attached :image
```

画面上での画像の表示方法

```html
app/views/items/index.html.erb <%= image_tag(item.image, class: "card-img-top")
%>
```

seedファイルの作成

```ruby
# db/seeds.rb
# 適当に8つ同じ画像を登録する場合
(1..8).each do |i|
  Item.find_or_create_by!(name: "item#{i}") do |item|
    item.description = "description#{i}"
    item.price = i * 11.11
    # modelsで関連付けしたものにファイルを読み込む
    item.image.attach(io: File.open(Rails.root.join('db/seeds/images/your-file-name.jpeg')),
                      filename: 'your-file-name.jpeg')
  end
end
```

画像を準備して上記へ保存しておく。

seedの実行

```sh
# seed実行
bundle exec rails db:seed
# drop -> migrate -> seed
bundle exec rails db:reset
# drop -> migrate
bundle exec rails db:migrate:reset
```

formの場合、file_fieldで指定すれば保存される

```html
<%= form_with model: item, url: admin_items_path do |f| %>
  <div class="mb-3">
    <%= f.label :image, class: "form-label" %>
    <%= f.file_field :image, required: true, accept: 'image/*', onchange: 'previewFileWithId(preview)', class: "form-control" %>
  </div>
    <div class="mb-3">
      <%= f.label :name, class: "form-label" %>
      <%= f.text_field :name, required: true, class: "form-control" %>
    </div>
  <div class="mb-3">
    <%= f.submit "Add New Item", class: "btn btn-dark"%>
  </div>
<% end %>
```

使用時は`item.image`のように使える

##### 開発

###### route

- routingについて
  - namespace:パスとフォルダ構成を変えたいとき
  - scope:パスのみ変えたいとき
  - module:フォルダ構成のみ変えたいとき

###### erb

- ボタンの実装例
  - `<%= button_to "Add new Item", new_admin_item_path, method: :get, class: "btn btn-dark"%>`
  - bootstrapを使用
```html
<!-- pathには引数を指定する -->
<%= button_to admin_item_path(item), { method: :delete, data: { turbo_confirm: "Delete this?" }, class: "btn btn-light" } do %>
<!-- アイコンを指定 -->
  <i class="bi bi-trash"></i>
<!-- アイコンなどを指定する場合はdo endでくくる -->
<% end %>
```
- 他のerbの読み込み
```js
// ./_header.html.erb
// ./_item.html.erb // 中は単数で記述。.eachを書くと.lengthの2乗で表示される
// ./index.html.erb
<%= render 'header' %>
<%= render @items %> // ファイル名と引数が同じ場合の省略形。@items.lengthの分だけ_itemを表示
```

###### cart model

- 多対多のモデル
  - `cart` - `cart_item` - `item`の関係にある
  - cartモデルの作成
    - `exec rails g model cart cart_item`
```ruby
# db/migrate/xx_create_carts.rb
  def change
    create_table :carts do |t|
      t.timestamps
    end
  end
# app/models/cart.rb
class Cart < ApplicationRecord
  # ここは自分で追記する
  has_many: :cart_items, dependent: :delete_all
  has_many: :items, through: :cart_items
end
```
  - cart_itemモデルの作成
    - `bundle exec rails g model cart_item cart:references item:references quantity:integer`
    - `cart:references`のように関連付けたい`モデル名:references`とするのがポイント
    - キーに右記が追加される`t.references :モデル名, foreign_key: true`

```ruby
# db/migrate/xx_create_cart_items.rb
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
# app/models/cart_item.rb
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
end
```
