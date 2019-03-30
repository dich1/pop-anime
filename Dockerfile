FROM ruby:2.5.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs graphviz vim tig
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn
RUN mkdir /pop-anime
WORKDIR /pop-anime
COPY Gemfile /pop-anime/Gemfile
COPY Gemfile.lock /pop-anime/Gemfile.lock
RUN bundle install
COPY . /pop-anime

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids

EXPOSE 3000
CMD RAILS_ENV=${RAILS_ENV} bundle exec pumactl start
