# creating base for final container
FROM ruby:3.0.4-alpine3.15 as base
WORKDIR /faenz-analytics
RUN apk update \
  && apk add make build-base libffi-dev sqlite sqlite-dev mariadb-dev\
  && rm -f /var/cache/apk/*
RUN gem install bundler

COPY . .
RUN touch _first_run
RUN EDITOR="notexist" bin/rails credentials:edit
RUN RAILS_ENV=production bundle exec rails assets:precompile

EXPOSE 3000
CMD ["bundle","exec","rails","runner", "setup.rb"]