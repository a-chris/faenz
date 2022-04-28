# creating base for final container
FROM ruby:3.0.4-alpine3.15 as base
WORKDIR /faenz-analytics
RUN apk update \
  && apk add make build-base libffi-dev sqlite sqlite-dev mariadb-dev\
  && rm -f /var/cache/apk/*
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle config set --local with 'production production_sqlite production_mysql'
RUN bundle install

# preparing assets 
FROM timbru31/ruby-node:3.0-alpine-14 as build_assets
WORKDIR /faenz-analytics
RUN apk update \
  && apk add make build-base libffi-dev sqlite sqlite-dev mariadb-dev\
  && rm -f /var/cache/apk/*
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
COPY package.json .
COPY yarn.lock .

RUN bundle config set --local with 'production production_sqlite production_mysql'
RUN bundle install
RUN yarn install

COPY . .
RUN EDITOR="notexist" bin/rails credentials:edit
RUN RAILS_ENV=production bundle exec rails assets:precompile

# continuing with the final image
FROM base

COPY --from=build_assets /faenz-analytics/public/assets ./public/assets
COPY . .
RUN touch _first_run
RUN EDITOR="notexist" bin/rails credentials:edit

EXPOSE 3000
CMD ["bundle","exec","rails","runner", "setup.rb"]