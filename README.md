# このプロジェクトについて

サーバー構築の練習用に簡単に作り直せる環境を Docker で提供できるようにするためのプロジェクト。

# 提供するコンテナの概要

- 通常の Linux サーバーと同じ感覚で操作できるように必要最低限のパッケージをインストール
- sshd を起動し、すぐに ssh でログインできる状態を提供する
- 双方向の通信確認用に同一の内容で 2 台のコンテナを起動する

# インストールされるパッケージ

- ssh
- sudo
- iputils-ping
- iproute2
- vim
- python

# ビルド手順

本ファイルと同一ディレクトリに.env ファイルを作成し、変数 USER と PASS を設定する(この情報に基づいて一般ユーザが作成される)。

```
USER=yourname
PASS=yourpass
```

- 本ファイルと同一ディレクトリに ssh の公開鍵 id_rsa.pub を配置する(一般ユーザの.ssh にコピーされる)。
- docker-compose up -d を実行し、コンテナを起動する

# 起動確認

docker ps -a を実行しコンテナが起動していることを確認する

出力例:

```
CONTAINER ID   IMAGE              COMMAND              CREATED         STATUS         PORTS     NAMES
cb8c84ae90b9   test_sandbox1   "/init.sh yourname"   7 seconds ago   Up 6 seconds             test_sandbox1_1
9583efab21a5   test_sandbox2   "/init.sh yourname"   7 seconds ago   Up 6 seconds             test_sandbox2_1
```

# コンテナへの接続

docker inspect を実行しコンテナの IP を調べる。引数には上記の docker ps で出力された名前を使用する。

- docker inspect test_sandbox_1

出力例:

```
  "NetworkSettings": {
            ...中略...
            "Networks": {
                "test_default": {
                    ...中略...
                    "IPAddress": "172.18.0.2",
                    ...中略...
                }
            }
        }
```

出力された IP に向けて ssh する。

- ssh -l yourname 172.18.0.2

コンテナを作り直した場合、接続元の.ssh/known_hosts を削除すること
(サーバーがすり替わったと判断されセキュリティの警告がでて接続できなくなるため)。
