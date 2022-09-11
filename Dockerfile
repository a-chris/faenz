FROM ruby:3.0.4-slim-bullseye
WORKDIR /faenz-analytics
RUN apt-get update
RUN apt-get install -y \
  libsqlite3-dev \
  libmariadb-dev

RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle config set --local with 'production production_sqlite production_mysql'
RUN apt-get install -y build-essential && \
  bundle install && \
  apt-get remove -y build-essential && \
  rm -rf /var/cache && \
  rm -rf tmp/cache

COPY . .
RUN touch _first_run
RUN EDITOR="notexist" bin/rails credentials:edit
RUN RAILS_ENV=production_sqlite bundle exec rails dartsass:install
RUN RAILS_ENV=production_sqlite bundle exec rails assets:precompile

EXPOSE 3000
CMD ["bundle","exec","rails","runner", "setup.rb"]
