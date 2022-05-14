# practical-sql-2

## Envrionment Setup
This book uses PostgreSQL. While that is easy enough to install locally, I preferred not to. Instead, I decided to use containers to standup the environment that I will use while working through this book. My laptop is running Fedora, so I am using podman. Most commands should work with Docker with a little modification. You'd have to remove the parts specifying a pod and skip the pod creation step.

### Container Setup
The first step is probably the easiest and that is just to download/pull the images that we want to use. In this case it is pgadmin4 and PostgreSQL 14.

```
$ podman pull docker.io/dpage/pgadmin4:latest
$ podman pull postgres:latest
```

Next I created a pod. Containers in the same pod can communicate with each other without extra setup. This also allows me to pause, stop, start, or restart all containers in the pod at once.

```
$ podman pod create --name postgres --publish 8080:80
```
Next I created a specific volume for this deployment. I'll be mapping /var/lib/postgres to it. In my mind, this will make it easier to migrate to a new version of the database if needed. Thestep after creating it just exports the mountpoint path to an environment variable. I used this when deploying the container.

```
$ podman volume create postgres
```
run pgadmin in container using the required environment variables...

```
$ podman run -d --name pgadmin4 --pod postgres -e PGADMIN_DEFAULT_EMAIL=admin@localhost.com -e PGADMIN_DEFAULT_PASSWORD=$PGADMIN_DEFAULT_PASSWORD
```

Here I test and varify that pgadmin is up and running.
```
$ curl -s localhost:8080/login|grep pgadmin
    <link type="text/css" rel="stylesheet" href="/static/js/generated/pgadmin.style.css?ver=60800"/>
        <link type="text/css" rel="stylesheet" href="/static/js/generated/pgadmin.css?ver=60800" data-theme="standard"/>
              <span class="d-flex justify-content-center pgadmin_header_logo"
```

Run postgres container
```
$ podman run -d --name pg14 --pod postgres --volume=postgres:/var/lib/postgresql/data:Z --volume=/home/chris/data:/data:Z -e "POSTGRES_PASSWORD=$POSTGRES_PASSWORD" -e POSTGRES_USER=postgres docker.io/library/postgres
```
In order to get this working so that the postgres user could write from the container and not just root, I had to modify the permissions on the host(my laptop). I ran the command shown belowto set the group owner to the gid of the postgres group in the cotainer.
```
$ podman unshare chgrp 999 data/
```

Connect to postgres container and verify that it is running.
```
$ podman container exec -it pg14 /bin/bash
root@postgres:/# su - postgres
postgres@postgres:~$ psql
psql (14.2 (Debian 14.2-1.pgdg110+1))
Type "help" for help.

postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)
```
```
postgres=# SELECT version();
                                                           version
-----------------------------------------------------------------------------------------------------------------------------
 PostgreSQL 14.2 (Debian 14.2-1.pgdg110+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit
(1 row)
```
