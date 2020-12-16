#!/bin/bash

set -e
bundle check || bundle install
yarn install --check-files

# When running docker stop, SIGTERM will be passed to the main process
exec "$@"
