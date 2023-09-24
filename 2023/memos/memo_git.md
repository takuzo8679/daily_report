# Gitの基本

## gitの仕組み
### 基本構造
- gitはversionごとにスナップショットで保存している
- 変更がないファイルは以前のファイルをそのまま使用
- 複数人で開発した時にマージが行いやすくなる
- それ以前は差分で保存していたが遅い経緯があった
- commitがスナップショットに当たる
### データ構造
それぞれ.git/objectsに格納される
- blobオブジェクト
    - 管理対象を圧縮したもの
    - ファイル名はハッシュ値になる
    - stage時に作成
    - `git cat-file -p <blobのid>` ファイル内容を表示
- treeオブジェクト
    - ディレクトリの構造を定義したオブジェクト
    - ディレクトリ内のファイルの数だけのblogを持つ
    - ディレクトリ内にディレクトリがある場合はtreeを持つ
    - 出力例
        - 
        ```sh
        # top階層のtreeオブジェクト=ディレクトリ構成を表示
        git cat-file -p main^{tree} 
        040000 tree 846f0270d14faf368d858ba000c04eceb7d4c95b    2023 # これはディレクトリ
        100644 blob 44b5ab2bc7fcf42e06dbbf96069674a0bc6f0f54    README.md
        # 2023のtreeオブジェクト=ディレクトリを表示
        git cat-file -p 846f0 # 2023 tree id
        040000 tree c58940f9188720c4347a365fc9d8bb2f271e326f    08
        040000 tree 5723b559d295581ef186a925aa3ee6078dd1ba6a    09
        040000 tree b5018ac3521da3ebbf6b6792e026e9223b67dae6    memos
        ```
    - commit時に作成される
- commitファイル
    - ツリーid、親コミットid、作成者、日付を記録@commit時
    - commit時に作成される
    - 出力例
        - 
        ```sh
        git log # commit idを調べる
        git cat-file -p 調べたcommit id 
        040000 tree b5018ac3521da3ebbf6b6792e026e9223b67dae6    memos
        tree b176170909607b72f91fe5e742a30c5a9caa7291
        parent 027f266b3e33881c6d7496660c60c746dd33c163
        author takuzo <mail> 1695323095 +0900
        committer takuzo <mail> 1695323095 +0900
        ```
### HEADとbranch
- HEAD
    - .git/HEADに実体がある
    - 中身はどのブランチにいるか：`ref: refs/heads/aa`
    - Detached HEADの場合はコミットIDになる 
- branch
    - .git/refs/heads 以下にブランチごとにファイルが存在する
        - main
        - develop
        - staging
        - ...
    - 中身はコミットID
    - branchの切り替えは上記のファイルの中身のコミットIDを切り替えているだけ
        - ポインタを書き換えるだけと表現されることが多い
### merge
- Fast Forward
    - 新規のコミットは作成されずにブランチのコミットIDが前に進む（ブランチの分岐がなかった場合）
- Auto Merge
    - 新規のコミットが作成される
    - コミットファイルにはペアレントが二つ持った状態になる

### rebase
- ブランチの基点を置き換えるのでリベース
- 動き
    - featブランチのコミットの親コミットをベースブランチに付け替える
    - ベースブランチがmergeするとmergeが完了する
    - この時はfast-forwardが起こる
- rebaseを用いたマージ
    - pull+option
        - git pull --rebase
    - fetch base
        - git fetch origin main
        - git rebase FETCH_HEAD
- mergeとの違い:コミット履歴が分岐されずに一直線になる