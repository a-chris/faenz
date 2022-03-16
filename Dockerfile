FROM ruby:3.0.3-alpine3.14
WORKDIR /faenz-analytics
RUN apk update && apk add make build-base libffi-dev sqlite sqlite-dev
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
RUN bundle exec rails assets:precompile

COPY . .

RUN RAILS_ENV=production bundle exec rails db:create db:migrate db:seed

EXPOSE 3000
CMD ["bundle","exec","rails","server", "-b", "0.0.0.0", "-e", "production"]