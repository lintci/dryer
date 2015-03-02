FROM ubuntu:trusty
MAINTAINER Gazelle

###### Packages
# Common
RUN apt-get update \
 && apt-get install -y \
    curl \
    wget \
 && rm -rf /var/lib/apt/lists/*

# Libs
RUN apt-get update \
 && apt-get install -y \
    autoconf \
    build-essential \
    imagemagick \
    libbz2-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libffi-dev \
    libglib2.0-dev \
    libjpeg-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libmysqlclient-dev \
    libncurses-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

 # Databases
 RUN apt-get update \
  && apt-get install -y \
     mysql-client \
     postgresql-client \
     --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

###### Docker


###### Ruby
RUN apt-get update \
 && apt-get install -y \
    procps \
 && rm -rf /var/lib/apt/lists/*

ENV RUBY_MAJOR 2.2 %>
ENV RUBY_VERSION <%= ruby_version %>

# some of ruby's build scripts are written in ruby
# we purge this later to make sure our final image uses what we just built
RUN apt-get update \
 && apt-get install -y \
    bison \
    ruby \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /usr/src/ruby \
 && curl -SL "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.bz2" \
  | tar -xjC /usr/src/ruby --strip-components=1 \
 && cd /usr/src/ruby \
 && autoconf \
 && ./configure --disable-install-doc \
 && make -j"$(nproc)" \
 && apt-get purge -y --auto-remove \
    bison \
    ruby \
 && make install \
 && rm -r /usr/src/ruby

# skip installing gem documentation
RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

# install things globally, for great justice
ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH
RUN gem install bundler \
 && bundle config --global path "$GEM_HOME" \
 && bundle config --global bin "$GEM_HOME/bin"

# don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

###### Create user
RUN mkdir -p <%= homedir %> \
 && groupadd -r <%= group %> -g 777 \
 && useradd -u 666 -r -g <%= group %> -d <%= homedir %> -s /sbin/nologin -c "Docker image user" <%= user %> \
 && chown -R <%= user %>:<%= group %> <%= homedir %>
WORKDIR <%= homedir %>

###### App Setup
# gems may be cacheable, so do minimal work first to
# install gems to minimize cache bust.
ONBUILD COPY Gemfile <%= homedir %>
ONBUILD COPY Gemfile.lock <%= homedir %>
ONBUILD RUN bundle install
ONBUILD COPY . <%= homedir %>
ONBUILD RUN chown -R <%= user %>:<%= group %> <%= homedir %>
ONBUILD USER <%= user %>

EXPOSE 8080
CMD unicorn
