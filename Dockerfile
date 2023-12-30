FROM quay.io/evl.ms/fullstaq-ruby:3.2.2-jemalloc-bullseye-slim
WORKDIR /faenz-analytics
RUN apt-get update
RUN apt-get install -y libsqlite3-dev

RUN gem install bundler -v 2.5.3

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle config set --local with 'production'

# build-essential needed to compile gems, ffi in particular
RUN apt-get install -y --no-install-recommends build-essential libyaml-dev && \
  bundle install --deployment && \
  apt-get remove -y build-essential && \
  apt-get autoremove -y && \
  rm -rf /var/cache && \
  rm -rf tmp/cache

COPY . .
RUN touch _first_run
RUN EDITOR="notexist" bin/rails credentials:edit
RUN RAILS_ENV=production_sqlite bundle exec rails dartsass:install
RUN RAILS_ENV=production_sqlite bundle exec rails assets:precompile

EXPOSE 3000
CMD ["bundle","exec","rails","runner", "setup.rb"]
