# preparing assets 
FROM timbru31/ruby-node:3.0-alpine-14 as build_assets
WORKDIR /faenz-analytics
RUN apk update \
  && apk add make build-base sqlite-dev mariadb-dev\
  && rm -f /var/cache/apk/*
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
COPY package.json .
COPY yarn.lock .

RUN bundle install
RUN yarn install

COPY . .
RUN EDITOR="notexist" bin/rails credentials:edit
RUN RAILS_ENV=production_sqlite bundle exec rails assets:precompile


FROM ruby:3.0.4-alpine3.15
WORKDIR /faenz-analytics
RUN apk update
RUN apk add make
RUN apk add sqlite-dev
RUN apk add mariadb-dev
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle config set --local with 'production production_sqlite production_mysql'
RUN apk add build-base && \
    bundle install && \
    apk del build-base && \
    rm -rf /var/cache/apk && \
    rm -rf tmp/cache

COPY . .
COPY --from=build_assets /faenz-analytics/public/assets ./public/assets
RUN touch _first_run
RUN EDITOR="notexist" bin/rails credentials:edit

EXPOSE 3000
CMD ["bundle","exec","rails","runner", "setup.rb"]