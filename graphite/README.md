## docker-graphite-centos6

### これなに？

 * `Graphite` をお手軽に `Docker` で試す環境を作る `Dockerfile`
 * `Graphite` の勉強用に作った

### 使い方

#### git clone

~~~~
git clone
~~~~

#### initial_data.json を修正

`graphite-web` にログインするユーザー名とパスワードはデフォルトでは以下の通り。

 * username : admin
 * password : hoge

環境に応じて `graphite/initial_data.json` の `username` や `password` を修正すること。

尚、`password` に関しては以下を参考にすること。

 * [Django でのユーザ認証](http://www.djangoproject.jp/doc/ja/1.0/topics/auth.html#id10)

#### monit.conf を修正

`monit` でプロセスを監視しており `Web` コンソールが利用出来る。ユーザー名とパスワードはデフォルトでは以下の通り。

 * username : admin
 * password : monit

この設定は `monit/monit.conf` に設定されているので環境に応じて `allow admin:monit` を修正すること。

#### docker build

~~~~
cd graphite
docker build -t yourname/your-repo .
~~~~

#### docker run

~~~~
docker run -d -t -p 3306 -p 2003 -p 2004 -p 7002 -p 80 -p 2812 yourname/your-repo
~~~~

