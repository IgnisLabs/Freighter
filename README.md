Freighter
=========

Easy docker development environment management for PHP and Laravel.

> **You don't need to have a Laravel project to use Freighter.**  
> You have more toys if you're using Laravel, but you certainly don't
> require to do so.
> 
> It does come with Laravel-oriented commands, but you don't need to use
> them.
> 
> It also does use the database environment variables names as defined
> by Laravel, but as long as you have an `.env` file with those
> variables declared, it's more than enough.

Installation
------------

You install it with composer:

```shell
# Install it with composer
$ composer require ignislabs/freighter
```

Then you need to run init just this first time (or when a new version is
released):

```shell
$ bash vendor/ignislabs/freighter/freighter init
```

> `init` copies the freighter binary to the root of your repo, makes it
executable and adds it to `.gitignore`, since you don't need to track it.

And now you're ready to use it:

```
$ ./freighter start
```

The Stack
---------

The stack provided is comprehensive, but we try to keep it as minimal as
possible by using Alpine Linux whenever possible.

- PHP 7.1 FPM ([latest](https://hub.docker.com/_/php/))
- MySQL 5.7 ([latest](https://hub.docker.com/_/mysql/))
- Nginx ([latest alpine](https://hub.docker.com/_/nginx/))
- Redis ([latest alpine](https://hub.docker.com/_/redis/))
- Beanstalkd (custom alpine — [latest](https://pkgs.alpinelinux.org/package/edge/community/x86/beanstalkd))

Ports
-----

Inside your containers, the ports will remain the default ones. But when
accessing them from the host machine it's a different story.

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

Inside your containers the host names will correspond to the services
names as defined in the Compose file, so you'll need to replace them in
your `.env` file:

```
# .env

# ...
DB_HOST=mysql
REDIS_HOST=redis
QUEUE_HOST=beanstalkd
```

If using Laravel you'll probably also need to add `QUEUE_HOST` in your
`config/queue.php` manually since Laravel comes with it hardcoded by
default. Just add `'host' => env('QUEUE_HOST', 'localhost'),` to the
`beanstalkd` connection.

MySQL
-----

Freighter uses the credentials from environment variables defined in
your`.env` file, so you can use those to connect from your host machine.

Just remember to use the correct port (`33060` by default).

The variable names follow the Laravel convention:

```
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=freighter
DB_USERNAME=freighter
DB_PASSWORD=secret
```

Commands
--------

Freighter comes with a few _native_ commands, and more will be coming.

Any unrecognized command will be handed down to `docker-compose`.

You can see any command's help by passing `-h`. Some commands will also
show help if you omit all arguments.

### Start and stop your environment

```shell
# start the environment in detached mode (up -d)
$ ./freighter start

# bring down the environment
$ ./freighter stop # this is just an alias to docker's native `down`
```

### Customize services

If you want to customize the compose file, you can copy the one in
vendor to your repo manually or by running `./freighter copy-services`.

If a compose file is found here, Freighter will use this one instead of
the one in vendor.

This way Youy can add services or customize the existing ones. As long
as you keep te same service names, you should be fine.

### Composer

```shell
$ ./freighter composer <command>
$ ./freighter c <command> # composer alias

# Example: require a package
$ ./freighter c require predis/predis
```
### Artisan

```shell
$ ./freighter artisan <command>
$ ./freighter art <command> # artisan alias

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

# Example: initialize behat
$ ./freighter behat --init
```

### Shell access

```shell
$ ./freighter shell <container>
$ ./freighter sh <container> # shell alias

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

```shell
# Connect to mysql console
$ ./freighter db:console
$ ./freighter db:clt # db:console alias
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

Just create a directory named `freighter.d` at the root of your repo and
add shell scripts in it, Freighter will be pick them up immediately.

These files need to declare functions prefixed as `_fcmd_`, for example:
`_fcmd_artisan`.

Take a look at the native ones in `vendor/ignislabs/freighter/freighter.d`
so you have an idea of how to write them.

> An artisan command to generate custom Freighter commands even quicker
> is in the works.
