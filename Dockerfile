FROM tutum.co/lintci/ruby:2.2.3
MAINTAINER LintCI

###### Install packages necessary for github-linguist and rugged
RUN apt-get update \
 && apt-get install -y \
    libicu-dev \
    cmake \
 && rm -rf /var/lib/apt/lists/*

###### Create user
RUN mkdir -p /home/app/
 # && groupadd -r app -g 777 \
 # && useradd -u 666 -r -g app -d /home/app/ -s /sbin/nologin -c "Docker image user" app \
 # && chown -R app:app /home/app/ \
 # && groupadd -r docker -g 778 \
 # && usermod -aG docker app
WORKDIR /home/app/

###### Install docker
RUN curl -sSL https://get.docker.com/ | sh

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY Gemfile /home/app/
COPY Gemfile.lock /home/app/
RUN bundle install --path=vendor/bundle --jobs=4 --retry=3
COPY . /home/app/
# RUN chown -R app:app /home/app/
# USER app

VOLUME /var/lib/docker

ENV REDIS_URL=CHANGEME

CMD foreman start worker
