# postgres

## 基本

### ターミナル

- 起動:`postgres -D /opt/homebrew/var/postgresql@14 `
  - 停止:`Ctrl+c`
- ユーザー作成:`createuser -P workuser` # workuserというユーザーをパスワード付き権限なしで作成
- db一覧:`psql -l`
- db接続:`psql -d your_db_name`

### 接続後

- 切断:`\q`
- ユーザー一覧表示:`\du`
- 権限付与`ALTER ROLE workuser CREATEDB;` # workuserにcreate dbの権限を付与
