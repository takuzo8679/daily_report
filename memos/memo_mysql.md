# mysql

## 管理

- 状態確認。systemctl status mysql
- ログイン。sudo mysql -u root [database-name]
  - mysql -u mydbuser -pyourpassword
- ファイル実行。sudo mysql -u root < initialize.sql 
- 設定ファイル確認。mysql --help | grep my.cnf
  - /etc/my.cnf /etc/mysql/my.cnf ~/.my.cnf
  - 左から順に読み込まれる
- 書き込み
  - sudo vim /etc/mysql/my.cnf
  - 末尾に書き込み
    - [mysqld]
      character-set-server=utf8
- mysql再起動。sudo systemctl restart mysql


## mysql >
- 公式。https://dev.mysql.com/doc/refman/8.0/ja/
- 一般
  - 言語確認。show variables like '%chara%';
  - 一覧確認。show databases;
  - DB作成。create database db01;
  - DB削除。drop database db01;
  - 使用中のユーザー表示。select user();
  - 操作対象のDB表示。select database();
  - 操作対象のDB設定。use db01;
- ユーザー
  - ユーザー一覧。select user from mysql.user;
  - ユーザー追加。create user dbuser01@localhost identified by 'yourpassword';
    - ローカルホスト
      - ユーザーがアクセスするhostを指定（このcloud9)
      - 省略すると%にデフォルト設定
  - ユーザー削除。drop user dbuser01@localhost;
  - 権限設定。grant all on db01.* to dbuser01@localhost;
    - 記載の通り。localhostアクセスに限定される
