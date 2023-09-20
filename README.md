# openaccounting-docker
Docker files to easily run OpenAccounting locally.

OpenAccounting needs three components to run:
- [oa-server](https://github.com/openaccounting/oa-server): an API server (written in Go)
- [oa-web](https://github.com/openaccounting/oa-web): a web interface (written in Angular)
- A mysql database

I personally like to run my software inside Docker containers. This repo contains a [docker-compose.yml](https://github.com/alokmenghrajani/openaccounting-docker/blob/main/docker-compose.yml) file
which will bring up 4 containers:
1. a maria/mysql database on an internal network.
2. git clone the latest version of [oa-server](https://github.com/openaccounting/oa-server), build it, and run it on the internal network.
3. git clone the latest version of [oa-web](https://github.com/openaccounting/oa-web), patch it, build it, and run it on the internal network.
4. run two socats to forward `port 8080` to [oa-server](https://github.com/openaccounting/oa-server) and `port 4200` to [oa-web](https://github.com/openaccounting/oa-web).

You can adjust the [docker-compose.yml](https://github.com/alokmenghrajani/openaccounting-docker/blob/main/docker-compose.yml) file if you want different ports.

To run things, simply do:
```
$ docker-compose build
$ docker-compose up
```

You can then connect to [http://localhost:4200](http://localhost:4200/settings). You'll have to set the server to `http://localhost:8080`. You can then [create your first user](http://localhost:4200/register). You'll need to manually mark the email as verified:
```
docker exec -it openaccounting-mysql mariadb -u root -psecret -h localhost --protocol tcp openaccounting -e 'update user set emailVerified=1';
```

## Notes
- The oa-web patch tells the web frontend to connect to localhost using `ws://` instead of `wss://` since localhost isn't using TLS.
- The oa-web code runs in development mode. Perhaps the default should be to include the `-prod` flag.
- This repo [contains](https://github.com/alokmenghrajani/openaccounting-docker/blob/main/init.sql) a concatenation of [schema.sql](https://github.com/openaccounting/oa-server/blob/master/schema.sql) and [indexes.sql](https://github.com/openaccounting/oa-server/blob/master/indexes.sql) which needs to be kept in sync.
- If you don't want to bother running the software on your own hardware, you can [sign up](https://openaccounting.io/) for a cloud-based account.
