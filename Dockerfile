FROM ruby:2.3.5

RUN mkdir /snip
WORKDIR /snip

RUN gem install bundler

# separate the Gemfile copy and run from the source to allow for caching
# see here: https://shiladitya-bits.github.io/Dockerization-of-gRPC-service-in-Ruby/
COPY Gemfile /snip
COPY Gemfile.lock /snip

# changed this from "frozen 1" because it was throwing bundle error
# RUN bundle config --global frozen 0

RUN bundle install --without development test --force
COPY lib /snip/lib

EXPOSE 50052
ENTRYPOINT [ "bundle", "exec" ]
CMD ["lib/start_server.rb"]