
FROM ruby:3.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN RAILS_ENV=production bundle exec rake assets:precompile
ENV RAILS_ENV=production
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
