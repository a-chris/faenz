FROM ruby:3.0.3-alpine3.14
WORKDIR /faenz-analytics
RUN apk update && apk add make build-base libffi-dev sqlite sqlite-dev
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
RUN bundle exec rails assets:precompile

COPY . .
RUN touch _first_run
RUN RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:create db:migrate db:seed

EXPOSE 3000
CMD ["bundle","exec","rails","runner", "setup.rb", "-e", "production"]