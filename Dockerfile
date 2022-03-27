FROM ruby:3.0.3-alpine3.15
WORKDIR /faenz-analytics
RUN apk update \
  && apk add make build-base libffi-dev sqlite sqlite-dev mariadb-dev\
  && rm -f /var/cache/apk/*
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
RUN bundle exec rails assets:precompile

COPY . .
RUN touch _first_run

EXPOSE 3000
CMD ["bundle","exec","rails","runner", "setup.rb"]