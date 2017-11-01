Freighter
=========

Easy docker development environment management for Laravel

Installation
------------

```shell
$ composer require ignislabs/freighter
$ php artisan vendor:publish --provider="IgnisLabs\Freighter\FreighterServiceProvider"

# Initialize (first-time only)
$ bash freighter init

# Now you can use it directly
$ ./freighter start
```

The Stack
---------

The stack provided is comprehensive, but trying to keep it as small as
possible by using alpine linux where we can.

- PHP 7.1 FPM ([latest](https://hub.docker.com/_/php/))
- MySQL 5.7 ([latest](https://hub.docker.com/_/mysql/))
- Nginx ([latest alpine](https://hub.docker.com/_/nginx/))
- Redis ([latest alpine](https://hub.docker.com/_/redis/))
- Beanstalkd (custom alpine — [latest](https://pkgs.alpinelinux.org/package/edge/community/x86/beanstalkd))

Ports
-----

Inside your containers, the ports will remain the default ones. But for
accessing from the host machine it's a different story.

Freighter plays nice with other services that you might be already
running by using easy to remember non-standard ports by default:

- `8000` for Nginx
- `33060` for MySQL
- `63790` for Redis
- `11301` for Beanstalkd

You can override these defaults by setting the appropriate environment
variables in your `.env` file to the desired values:

```
# .env

# ...

# Freighter
F_WEB_PORT=80
F_MYSQL_PORT=3306
F_REDIS_PORT=6379
F_QUEUE_PORT=11300
```

Hosts
-----

Inside your containers the hosts will correspond to the containers names
as defined in the `docker-compose.yml` file, so you'll need to replace
them in your `.env` file:

```
# .env

# ...
DB_HOST=mysql
REDIS_HOST=redis
QUEUE_HOST=beanstalkd
```

You'll probably also need to use `QUEUE_HOST` in your `config/queue.php`
manually since Laravel comes with it hardcoded by default. Just add
`'host' => env('QUEUE_HOST', 'localhost'),` to the redis connection.

MySQL
-----

Freighter uses the DB credentials defined in your`.env` file, so you can
use those to connect from your host machine. Just remember to use the
correct port (`33060` by default).

Commands
--------

Freighter comes with a few built-in commands, but more will be coming.

Any unrecognized command will be handed down to `docker-compose`.

You can see any command's help by either passing `-h`. Some commands
will show help if you omit all arguments

### Start and stop your environment

```shell
# start the environment in detached mode (up -d)
$ ./freighter start

# bring down the environment
$ ./freighter stop # this is just an alias to docker's native `down`
```

### Composer

```shell
$ ./freighter composer <command>
$ ./freighter c <command> # alias

# Example: require a package
$ ./freighter c require predis/predis
```
### Artisan

```shell
$ ./freighter artisan <command>
$ ./freighter art <command> # alias

# Example: run artisan tinker
$ ./freighter art tinker

# Example: publish vendor files
$ ./freighter art vendor:publish --tag="config"
```

### Laravel logs

```shell
$ ./freighter logs:laravel [<logfile>]

# Example: default laravel logs
$ ./freighter logs:laravel # will tail storage/logs/laravel.log

# Example: other laravel logs (if you have any)
$ ./freighter logs:laravel other # will tail storage/logs/other.log
```

### Testing

```shell
# phpspec
$ ./freighter phpspec <command>
$ ./freighter spec <command> # alias

# Example: generate a spec for a class
$ ./freighter spec desc App\\Foo\\Bar\\Baz

# behat
$ ./freighter behat <command>

# Example: init behat
$ ./freighter behat --init
```

### Shell access

```shell
$ ./freighter shell <container>
$ ./freighter sh <container> # alias

# Example: drop to bash on app container
$ ./freighter shell app

# Use a different shell (for alpine containers)
F_SHELL=sh ./freighter sh nginx
```

### MySQL

```shell
$ ./freighter db:dump [<file>]

# Example: dump to stdout
$ ./freighter db:dump

# Example: dump to file
$ ./freighter db:dump dump.sql
```

### Running Docker Compose commands

As I mentioned earlier, any unrecognized command will be handed down to
`docker-compose`. So you can run any `docker-compose` command, with the
added benefit of having the environment variables in place.

```shell
# Rebuild services without cache
$ ./freighter build --no-cache

# Show live redis logs
$ ./freighter logs -f redis
```

### Custom commands

Freighter is incredibly easy to extend (as long as you know your way
around bash scripting :bowtie:).

Just add files in the `freighter.d` directory and they will be picked up
immediately.

These files need to declare functions prefixed as `_fcmd_`, for example:
`_fcmd_artisan`.

Take a look at how they are implemented and you'll pick it up real quick.

> An artisan command to generate custom Freighter commands even quicker
> is in the works.
