# docker

## コマンド

- docker login
- docker pull hello-world
- docker run hello-world
- docker ps -a
- docker run -it image-name command
  - -it: bash起動時に必要。中に入る。
  - image-name: ubuntuなどののimageをpullしてrunする
  - command: コンテナ起動時に実行するプログラム。未指定の場合はデフォルトコマンドが実行される
  - --name: nameを付ける
  - -d: コンテナを起動後にdetachする。バックグラウンドで動かす
  - --rm: コンテナがexit後に自動でrmされる
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
  - -t: 名前指定

## dockerfile

- FROM: baseとなるimage
- ADD:
- RUN: 実行するコマンド
- CMD:

## 流れ

- docker hubからimageをpull、またはdockerfileを作成してbuild
- docker runでimageからコンテナを作成して実行
  - run=create+start
