FROM --platform=arm64 ruby:3.0.3-alpine3.15
WORKDIR /faenz-analytics
RUN apk update && apk add make build-base libffi-dev sqlite sqlite-dev
RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["bundle","exec","rails","server", "-b", "0.0.0.0", "-e", "production"]