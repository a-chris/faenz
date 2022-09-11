FROM ruby:3.0.4-alpine3.15
WORKDIR /faenz-analytics
RUN apk update
RUN apk add make \
  sqlite-dev \
  mariadb-dev \
  libsass
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
RUN touch _first_run
RUN EDITOR="notexist" bin/rails credentials:edit
RUN RAILS_ENV=production_sqlite bundle exec rails dartsass:build
RUN RAILS_ENV=production_sqlite bundle exec rails assets:precompile

EXPOSE 3000
CMD ["bundle","exec","rails","runner", "setup.rb"]
