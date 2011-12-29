#!/bin/bash

start() {
  echo "Starting services!"
  mongod &
  /usr/local/Cellar/nginx/1.0.10/sbin/nginx &
  /usr/local/sbin/php-fpm.dSYM
}
stop() {
  echo "Stopping PHP FastCGI!"
  kill `ps ax|grep mongod|awk '{print $1}'|xargs`
  kill `ps ax|grep nginx|awk '{print $1}'|xargs`
  kill `ps ax|grep php-fpm|awk '{print $1}'|xargs`
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  *)
    echo "Usage: php-fastcgi {start|stop|restart}"
    exit 1
    ;;
esac
exit $RETVAL
