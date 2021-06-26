FROM ruby:2.4-alpine

RUN apk update && apk add --no-cache build-base nodejs tzdata sqlite-dev

WORKDIR /app/recipe

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install
COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
