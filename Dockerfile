FROM ruby:2.5-alpine3.7

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev" \
    RUBY_PACKAGES="ruby-json yaml nodejs git"

# Update and install base packages and nokogiri gem that requires a
# native compilation
RUN apk update && \
    apk upgrade && \
    apk add --no-cache --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES && \
    mkdir -p /myapp

# Copy the app into the working directory. This assumes your Gemfile
# is in the root directory and includes your version of Rails that you
# want to run.
WORKDIR /myapp
COPY Gemfile /myapp
COPY Gemfile.lock /myapp

RUN gem install bundler
RUN bundle config build.nokogiri --use-system-libraries && \
    bundle install --jobs=4 --retry=10 --clean

# Copy the source files. If the application is referenced with git url, it can run without volume mount.
COPY app /myapp/app
COPY bin /myapp/bin
COPY config /myapp/config
COPY db /myapp/db
COPY lib /myapp/lib
COPY log /myapp/log
COPY public /myapp/public
COPY tmp /myapp/tmp
COPY vendor /myapp/vendor
COPY config.ru /myapp
COPY Rakefile /myapp

COPY docker/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]