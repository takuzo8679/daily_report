# docker

## コマンド

- docker login
- docker pull hello-world
- docker run hello-world
- docker ps -a
- docker run image-name command
  - image-name: ubuntuなどののimageをpullしてrunする
  - command: コンテナ起動時に実行するプログラム。未指定の場合はデフォルトコマンドが実行される
  - -it: bash起動時に必要。中に入る。
  - --name: nameを付ける
  - -d: コンテナを起動後にdetachする。バックグラウンドで動かす
  - --rm: コンテナがexit後に自動でrmされる
  - -v host:container: マウント
    - container側にフォルダがなければ作成される
    - 例：-v .hostFolder:/shareFolder
  - --volumes-from container-name
    - container-nameのvolumeと共有することができる
  - -u userId: groupId: user:group指定
    - containerはデフォルトではrootで実行される。フォルダ共有している場合は権限が問題になることが多い。
    - 例。-u $(id -u):$(id -g)
      - id -u:実行者のuserId
      - id -g:実行者のgroupId
  - -p host:containerポート設定
    - portのpと一緒だが、publishのp
    - 例
      - docker run -it -p 12345:8888 --rm jupyter/datascience-notebook bash
  - -P, --expose:コンテナが使用しているportを同一LANに公開する
  - --network=myapp
    - 複数コンテナを接続させるためのネットワークの指定
    - 実行コマンドはcurl nginx:80のように記載
  - -w: 作業ディレクトリ
  - 資源
    - AWSや、共有マシンでは必要になる
    - --cpus 4 # 物理コア数
    - --memory 2g
- コンテナからの抜け方
  - exit:コンテナもexit(プロセスが終了するので)
  - ctrl+p+q(detachと呼ばれる):コンテナ起動したまま
- docker restart container-id
- docker exec -it container-id bash
- docker attach container-id
- docker commit container-id image(repository)-name:tag-name
  - コンテナからimageを作る
  - tagがなければlatestが入る
  - 停止したコンテナのデバッグをする際はcommitでイメージ化した後にrunで中に入る（startでは起動時のコマンドが実行されてしまうため）
- docker images
- docker tag source target # 新しいimage名をつける
  - docker tag ubuntu:updated takuzo8679/my-first-repo
- image名のルール
  - hostname:port/username/repository:tag
  - デフォルト：registry-1.docker.io/library/xxxxx:latest
- docker rmi image
- docker stop container
  - docker stop $(docker ps -q) # 稼働中のコンテナ停止
    - docker ps -q # 稼働中のコンテナID表示
- docker rm container
  - status:stopのみ削除
  - -fをつければ強制削除
  - docker rm $(docker ps -aq) # 全コンテナ削除
    - docker ps -aq # 全コンテナid表示
- docker system prune
- docker build directory
  - -t: dockerfile名を指定
  - -f: dockerfileを指定する。デフォルトは./Dockerfile
  - M1チップを使用の場合は下記を付加が必要になる場合がある
    - --platform linux/amd64
      - マルチプラットフォーム（異なる種類のハードウェアやOSで同じような動作をすること）への対応
      - 環境によっては遅くなるという報告がある
    - buildで上手くいかない場合はbuildxというコマンドがある
- docker inspect container
  - NanoCpusが割り当てられているCPU数(nano単位)
  - Memoryが割り当てられているmemory(byte)
- docker save image > output-image.tar # tarに圧縮する
- docker volume
  - docker volumeの情報取得
  - docker volumeとは、dockerのsystem側でコンテナ終了時データの保存、コンテナ間データ共有を可能にする（containerのライフサイクルとは独立して管理される）
  - docker volume create xxxで新規に作成
- docker network create myapp
  - myappというネットワークを作成
- docker diff container-name
  - コンテナ起動後の変更ファイルを出力
  - Dockerfile記述時のデバッグに有効

## dockerfile

- FROM
  - 原則最初に記載
  - baseとなるimage
  - 最下層のレイヤー
  - 基本的にOSを指定することになる
    - ubuntu, debian, alpineなど
  - Docker imageは大きくなりがちなので、ここでは必要最低限のOSを指定すると良い
- RUN
  - Linuxコマンドを実行
  - RUNを実行することでimageをカスタマイズする
  - RUN毎にレイヤーが作られる
    - imageのLayer数は小さくする
      - &&, \で繋げる
      - apt-get update && apt-get install -y \
        - xxx \
        - yyy \
        - zzz
- CMD
  - 原則最後に記載
  - image立ち上げ時にデフォルトで実行されるコマンド
  - `CMD ["実行コマンド", "param1", "param2"]`
  - CMDはLayerを作らない
- cache
  - 一度作られたレイヤーはcacheの保存される
  - 開発時はうまく使って時間短縮する
- COPY
  - hostのファイルやフォルダをイメージ内に含ませる
  - COPY . . としてhostのファイルをすべてコンテナ内に含ませることが良く行われる
- ADD
  - tarの圧縮ファイルをコピーして持ってきたい場合に使う
    - 自動で解凍しておく
  - それ以外はCOPYを使う
- ENTRYPOINT
  - docker runでコンテナ起動時に実行されるコマンド
    - CMDとの違い
      - docker runで上書きできない
  - 記載方法：ENTRYPOINTにコマンドを記載して、引数をCMDに記載する
  - 引数は上書き可能
  ```docker
  ENTRYPOINT ["ls"]
  CMD ["--help"]
  ```
- ENV
  - 環境変数を指定
  ```docker
  ENV key1 value
  ENV key2=value
  ENV key3="v a l u e" key4=v\ a\ l\ u\ e
  ENV key5 v a l u e
  ```
- WORKDIR directory
  - 記載以降は指定したdirectoryで作業がされる
  - directoryがなければmkdirされる
  - bashで入った場合もそこで実行される
- EXPOSE
  - 明確化目的でコンテナ起動時に公開することが分かっているportを記述する
  - 公開にはrunオプションで-Pが必要
  - 公開サーバーにデプロイする際に使用する
- ARGS
  - ビルド時の変数として使用する
  - 複雑になるので使用しない方が良いらしい
    ```docker
    ARGS ${node_env:-production}
    ENV node_env
    ```

## 用語

- docker daemon
- build context
  - docker build時に必要な情報
    - コマンドで指定フォルダ内に含まれるファイルも含まれる

## 設定

- AWS
  - sudo gpasswd -a ubuntu docker
    - 毎回sudoを実行する手間を省略
    - ubuntuというuserにdockerの権限を付与する

## 作成から起動までの流れ

- docker hubからimageをpull、またはdockerfileを作成してbuild
- docker runでimageからコンテナを作成して実行
  - run=create+start

## docker-compose

- 用途
  - コンテナを複数使うとき
  - docker runのコマンドが長い時
- コマンド
  - docker-compose build
  - docker-compose up
    - imageがなければbuildも行う
    - --buildでビルドも行える
  - docker-compose ps
  - docker-compose down
    - stopしてrm
  - docker-compose exec web bash
- networks
  - フロントとバックでリポジトリが分かれる際に有効
  - internal(private), external(public)を定義してRDBの公開を避けられる
- 文法

```yml
version: "3"
# docker volumeの宣言。docker内でデータの保存と共有が可能
volumes:
  db-data:

# networkは書かなくても自動で構成してくれる

# 右記と同じになるdocker run -v .:/product-register -p 3000:3000 -it image bash
services:
  web:
    # DockerFileからbuildする場合
    build: .
    ports:
      - 3000:3000
    # -w の作業ディレクトリ
    working_dir: /app
    volumes:
      - .:/product-register
    environment:
      - DATABASE_PASSWORD=postgres # POSTGRES_PASSWORDと同じにすること
      - DATABASE_PASSWORD2=$(READ_FROM_ENV_BY_SHELL) #${}ではなく$()
    # ファイルから読み込み
    env_file:
      - .env
    tty: true
    stdin_open: true
    # 下記のserviceの後に作成する
    depends_on:
      - db
    # このサービスから他のサービスにアクセス可能になる
    links:
      - db

  db:
    # buildせずにimageを使用する場合
    image: postgres
    volumes:
      # docker volumeを指定
      - db-data:/var/lib/postgresql/data
    # これを設定しないと動かない
    environment:
      - "POSTGRES_USER=postgres"
      - "POSTGRES_PASSWORD=postgres"
```

## 設計方針

- ベースイメージは最軽量のalpineの利用を検討する
- 1コンテナに1プロセス（一つの関心ごと）
- 複数プロセスを接続する場合はソケットではなくネットワークで行う
  - ツール：docker-compose, Kubernetes, ECS
- 冪等性が求められる
  - volume使用時は要注意
- Webアプリの12の設計方針
  - https://12factor.net/ja/
- セキュリティ
  - rootユーザーは使わない
    - USERコマンドを使用する
  - Dockerイメージは公式を使用する
  - ホストファイルのマウントは最小範囲、最小権限で行う
  - .dokcerignoreで不要なパスがイメージに含まれるのを防ぐ
    - 軽量化にもつながる
- ログはdata volumeに記載する
  - dockerはコンテナlayerに書き込みファイルがない場合、イメージlayerを一つずつ探すので書き込みが遅くなる
  - コンテナ停止後に取得可能
- 軽量かつプロダクションを意識したイメージ例
  - https://y-ohgi.com/introduction-docker/3_production/dockerfile/#_5
- Dockerfileのビルド時の依存関係
  - ソースファイル更新時に毎回依存関係の更新が発生しないようにする
  - まず依存関係をinstallしてからCOPY . . を行う
    - COPY . .　で変更のあったファイルだけを更新するため
    - Dockerは更新があった手前のレイヤーまではキャッシュを使用するため
  - .dockerignoreにnode_modulesを記載しておく
  - nodeのサンプルコードは下記。Gemfileでも同様
    ```dockerfile
    COPY package.json package_lock.json ./
    RUN npm install
    COPY . .
    ```

## databaseのユーザーとIDについて

- postgreの唯一の初期ユーザーとパスワードはどちらもpostgres
- Dockerを起動する過程で他のユーザーが自動で作られるわけではない
- 使用するuserはpostgresを指定する必要がある
- パスワードは変更可能だが、DATABASE_PASSWORDとPOSTGRES_PASSWORDを一致させる必要がある
- パスワード変更時はdocker volumeの削除が必要

## マルチステージ ビルド

- 構築時の依存関係と実行時の依存関係を分離する
  - 例えば本番環境のコンテナにはbuild用のツールは不要
