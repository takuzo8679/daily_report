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
- docker images
- docker tag source target # 新しいimage名をつける
  - docker tag ubuntu:updated takuzo8679/my-first-repo
- image名のルール
  - hostname:port/username/repository:tag
  - デフォルト：registry-1.docker.io/library/xxxxx:latest
- docker rmi image
- docker rm container
- docker stop container
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
  - docker volumeとは、dockerのsystem側でコンテナ終了時データの保存、コンテナ間データ共有を可能にする

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

## 流れ

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
- 文法

```yml
version: "3"
# docker volumeの宣言。docker内でデータの保存と共有が可能
volumes:
  db-data:

# 右記と同じになるdocker run -v .:/product-register -p 3000:3000 -it image bash
services:
  web:
    # DockerFileからbuildする場合
    build: .
    ports:
      - "3000:3000"
    volumes:
      - ".:/product-register"
    environment:
      - "DATABASE_PASSWORD=postgres"
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
      - "db-data:/var/lib/postgresql/data"
```
