FROM ruby:2.7.0

# Install dependencies
RUN apt-get update -qq \
    && apt-get install -y build-essential \
    && apt-get install -y libxml2-dev libxslt1-dev \
    && apt-get install -y libpq-dev \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y nodejs yarn \
    && apt-get clean

ENV RACK_ENV=production \
    NODE_ENV=production \
    RAILS_LOG_TO_STDOUT=true \
    RAILS_ENV=production

RUN mkdir /musiclist_application
WORKDIR /musiclist_application

# Install gems
ADD Gemfile* /musiclist_application/
RUN gem install bundler:2.1.4 \
    && bundle config set deployment 'true' \
    && bundle config set without 'development' \
    && bundle install

# Install application
ADD . /musiclist_application

# Perform post-installation tasks
RUN bundle exec rake tmp:create \
    && bundle exec rake assets:precompile \
    && bundle exec rake assets:clean \
    && bundle exec rake tmp:clear

# Start the application server
EXPOSE 3000
CMD ["bin/web"]
