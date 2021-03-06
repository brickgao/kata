# Kata

[![Build Status](https://travis-ci.org/brickgao/kata.svg?branch=master)](https://travis-ci.org/brickgao/kata) [![Coverage Status](https://coveralls.io/repos/github/brickgao/kata/badge.svg?branch=master)](https://coveralls.io/github/brickgao/kata?branch=master)

A kata for learning Ruby on rails.

## Install

Set up your `crontab`, `MySQL` / `MariaDB`, `Redis` and `Elasticsearch`, then:

```bash
$ RAILS_ENV="production" rake db:migrate
$ RAILS_ENV="production" bundle install
$ RAILS_ENV="production" SECRET_KEY_BASE="YOUR_SERCET_KEY_BASE" SENTRY_DSN="YOUR_SENTRY_DSN" rails s Puma
$ RAILS_ENV="production" SECRET_KEY_BASE="YOUR_SERCET_KEY_BASE" SENTRY_DSN="YOUR_SENTRY_DSN" rails runner script/create_default_admin.rb
$ sudo echo "0 */1 * * * RAILS_ENV=\"production\" SECRET_KEY_BASE=\"YOUR_SERCET_KEY_BASE\" SENTRY_DSN=\"YOUR_SENTRY_DSN\" rails runner script/update_hot_posts.rb" >> /etc/crontab
```

If you would like to use Docker, install `crontab`, `docker` and `docker-compose`, then:

```bash
$ export SECRET_KEY_BASE="YOUR_SERCET_KEY_BASE"
$ export SENTRY_DSN="YOUR_SENTRY_DSN"
$ docker-compose build
$ docker-compose up
$ docker exec kata_app_1 rake db:schema:load
$ docker exec kata_app_1 rails runner script/create_default_admin.rb
$ sudo echo "0 */1 * * * docker exec kata_cron_1 rails runner /app/script/update_hot_posts.rb" >> /etc/crontab
```

## Features

* Basic features related to users, e.g. signup, login, change your password or avatar.
* Make a post or a comment include gists, pictures and links. Posts also support Markdown's syntax.
* Send a message to other users, and start a chat.
* Use nodes to divide different type of posts.
* Get most popular posts in this forum.
* Search your post.

## Screenshots

![](./screenshots/screenshot1.png)

![](./screenshots/screenshot2.png)

![](./screenshots/screenshot3.png)


## License

MIT
