#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
EDITOR="notexist" bundle exec rails credentials:edit
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
