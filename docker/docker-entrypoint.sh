#!/bin/bash
set -e

if [ $1 = 'bin/rails' ] && [ $2 = 's' ] ; then
    rm -f /myapp/tmp/pids/server.pid
    bin/rails db:migrate db:seed
fi

exec "$@"
